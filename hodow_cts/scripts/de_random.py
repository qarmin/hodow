#!/usr/bin/env python3
"""A Python port of deqp's `de::Random` and `deStringHash`, for the generators that have to replay a test group's random draws.

`selftest()` checks the port against the streams that `src/tcu/random.rs` pins as captured from upstream.
A pure text helper: no cargo and no compilation.
"""

import struct

MASK = 0xFFFFFFFF


def de_string_hash(text):
    value = 5381
    for byte in text.encode("utf-8"):
        value = (((value << 5) & MASK) + value + byte) & MASK
    return value


def to_f32(value):
    return struct.unpack("<f", struct.pack("<f", value))[0]


class DeRandom:
    def __init__(self, seed):
        self.x = ((-seed) & MASK) ^ 123456789
        self.y = (362436069 * seed) & MASK
        self.z = 521288629 ^ (seed >> 7)
        self.w = 88675123 ^ ((seed << 3) & MASK)

    def get_uint32(self):
        w = self.w
        t = (self.x ^ (self.x << 11)) & MASK
        self.x, self.y, self.z = self.y, self.z, w
        w = ((w ^ (w >> 19)) ^ (t ^ (t >> 8))) & MASK
        self.w = w
        return w

    def get_float(self):
        return to_f32(to_f32(self.get_uint32() & 0xFFFFFFF) / to_f32(float(0xFFFFFFF + 1)))

    def get_int(self, minimum, maximum):
        if minimum == -(2**31) and maximum == 2**31 - 1:
            value = self.get_uint32()
            return value - (1 << 32) if value >= (1 << 31) else value
        span = (maximum - minimum + 1) & MASK
        value = ((minimum & MASK) + self.get_uint32() % span) & MASK
        return value - (1 << 32) if value >= (1 << 31) else value


def selftest():
    expected = {
        0x124FEF: [0x4ECE6FA9, 0x15FA8A38, 0x9A9E2CE2, 0x44F9B2CE, 0x79772EDF, 0xB81DC083, 0xD38F125E, 0x5A69A523],
        0: [0xDCA345EA, 0xDCA35E7E, 0x52E219CC, 0x1F7F4828, 0xD935D238, 0x1FA337CE, 0x5DCD618F, 0xB8165C16],
        1: [0xDCA3421A, 0x1B511116, 0x95104E5A, 0xD88D4708, 0x1EF87D91, 0x8DB206F9, 0x9AC7EB8B, 0x28C04ADC],
    }
    for seed, stream in expected.items():
        rnd = DeRandom(seed)
        assert [rnd.get_uint32() for _ in range(8)] == stream, seed
    rnd = DeRandom(0)
    assert abs(rnd.get_float() - 0.789861619) < 1e-8
    print("de_random selftest ok")


if __name__ == "__main__":
    selftest()
