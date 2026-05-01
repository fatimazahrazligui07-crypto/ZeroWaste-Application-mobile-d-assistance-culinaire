<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    // Register / Signup
    public function signup(Request $request)
    {
        $validated = $request->validate([
            'firstname' => 'required|string|min:2|max:50',
            'lastname' => 'nullable|string|max:50',
            'username' => 'required|string|min:3|max:50|unique:users,username',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|string|min:8|confirmed', // requires password_confirmation field
        ]);

        $user = User::create([
            'firstname' => $validated['firstname'],
            'name' => $validated['firstname'],
            'lastname' => $validated['lastname'] ?? null,
            'username' => $validated['username'],
            'email' => $validated['email'],
            'password' => Hash::make($validated['password']),
        ]);

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'message' => 'User registered successfully',
            'access_token' => $token,
            "user" => $user,
            'token_type' => 'Bearer',
        ], 201);
    }

    // Login
    public function login(Request $request)
    {
        $validated = $request->validate([
            'email' => 'required|email|exists:users,email',
            'password' => 'required|string|min:8',
        ]);

        $user = User::where('email', $validated['email'])->first();

        if (!$user || !Hash::check($validated['password'], $user->password)) {
            throw ValidationException::withMessages([
                'email' => ['The provided credentials are incorrect.'],
            ]);
        }

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'message' => 'Logged in successfully',
            'access_token' => $token,
            'token_type' => 'Bearer',
            "user" => $user
        ]);
    }

    // Logout
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'message' => 'Logged out successfully',
        ]);
    }

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
