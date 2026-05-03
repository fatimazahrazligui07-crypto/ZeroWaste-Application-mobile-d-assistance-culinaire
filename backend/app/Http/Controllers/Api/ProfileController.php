<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class ProfileController extends Controller
{
    /**
     * Get the authenticated user's profile
     */
    public function show(Request $request)
    {
        $user = Auth::user();

        return response()->json([
            'id' => $user->id,
            'firstname' => $user->firstname,
            'lastname' => $user->lastname,
            'username' => $user->username,
            'email' => $user->email,
            'avatar' => $user->avatar,
            'bio' => $user->bio,
            'role' => $user->role,
            'created_at' => $user->created_at,
        ]);
    }

    /**
     * Update the authenticated user's profile
     */

    public function update(Request $request)
    {
        $user = Auth::user();

        $validator = Validator::make($request->all(), [
            'firstname' => 'nullable|string|max:255',
            'lastname' => 'nullable|string|max:255',
            'username' => [
                'nullable',
                'string',
                'max:255',
                Rule::unique('users')->ignore($user->id),
            ],
            'email' => [
                'nullable',
                'email',
                'max:255',
                Rule::unique('users')->ignore($user->id),
            ],
            
        ]);

        if ($validator->fails()) {
            $errors = $validator->errors();
            $field = $errors->keys()[0] ?? 'unknown';
            $message = $errors->first();

            return response()->json([
                'field' => $field,
                'message' => $message
            ], 422);
        }

        if ($request->has('firstname')) {
            $user->firstname = $request->firstname;
        }

        if ($request->has('lastname')) {
            $user->lastname = $request->lastname;
        }

        if ($request->has('username')) {
            $user->username = $request->username;
        }

        if ($request->has('email')) {
            $user->email = $request->email;
        }
       

        $user->save();

        return response()->json([
            'message' => 'Profile updated successfully',
            'user' => [
                'id' => $user->id,
                'firstname' => $user->firstname,
                'lastname' => $user->lastname,
                'username' => $user->username,
                'email' => $user->email,
                'bio' => $user->bio,
                'avatar' => $user->avatar,
            ]
        ]);
    }

    /**
     * Update password (if you want to keep it separate)
     */
    public function updatePassword(Request $request)
    {

        $id = auth()->user()->id;

        $user = User::findOrFail($id);

        $validator = validator($request->all(), [
            'old_password' => 'required',
            'password' => 'required|min:8|regex:/[A-Za-z]/',
        ]);

        if ($validator->fails()) {
            $error = collect($validator->errors())->flatten()->first();
            $field = collect($validator->errors())->keys()->first();
            return response()->json([
                'field' => $field,
                'message' => $error
            ], 422);
        }

        if (!Hash::check($request->old_password, $user->password)) {
            return response()->json(["field" => "old_password", 'message' => 'The old password is invalid'], 422);
        }

        $user->password = Hash::make($request->password);
        $user->save();

        return response()->json(['message' => 'Password updated successfully']);
    }
}
