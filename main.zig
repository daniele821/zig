const std = @import("std");
const aes = std.crypto.core.aes;

pub fn main() !void {
    var key: [32]u8 = undefined; // 256-bit (32 bytes) AES key
    var src: [32]u8 = undefined; // Two AES blocks (16 * 2 = 32 bytes)
    var dst: [32]u8 = undefined; // Buffer to hold the encrypted data

    // Initialize the key with some values
    @memset(&key, 0xAB);
    @memset(&src, 'A'); // Example plaintext data

    // Initialize the AES encryptor with the key
    aes.Aes256.initEnc(key).encryptWide(2, &dst, &src);

    // Print the encrypted data
    std.debug.print("encrypted data: {s}\n", .{dst});

    aes.Aes256.initDec(key).decryptWide(2, &dst, &src);

    std.debug.print("encrypted data: {s}\n", .{src});
}
