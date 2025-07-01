#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title calcToken
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Placeholder" }
# @raycast.packageName steam

# Documentation:
# @raycast.author Jimmy Lee

import time
import base64
import hmac
import hashlib
import struct
import sys

class SteamAuth:
    def int_to_byte(self, int_value):
        return int_value & 0xff
    
    def start_array_to_zero(self, array):
        mode = {}
        int_mode_array = 0
        for test in array:
            mode[int_mode_array] = self.int_to_byte(test)
            int_mode_array += 1
        return mode
    
    def get_steam_time(self, localtime=False):
        # Using server time to improve speed, as long as server time is in sync with Steam
        return int(time.time())
        # The following code is not used but preserved from the original PHP
        """
        if localtime:
            return int(time.time()) + 10
        data = {'steamid': 0}
        url = 'http://api.steampowered.com/ITwoFactorService/QueryTime/v0001'
        
        import requests
        response = requests.post(url, data=data).json()
        return response['response']['server_time']
        """
    
    def create_time_hash(self, time_value):
        time_value = time_value // 30
        time_array = []
        for i in range(8, 0, -1):
            time_array.append(self.int_to_byte(time_value))
            time_value >>= 8
        
        time_array = time_array[::-1]  # Reverse array
        
        # Convert array to bytes
        return bytes(time_array)
    
    def create_hmac(self, time_hash, shared_secret_decoded):
        hash_obj = hmac.new(shared_secret_decoded, time_hash, hashlib.sha1)
        hash_digest = hash_obj.digest()
        
        # Equivalent to unpack('C*', pack('H*', $hash)) in PHP
        hmac_values = [b for b in hash_digest]
        return hmac_values
    
    def generate_steam_guard_code(self, shared_secret):
        if shared_secret == "Shared Secret Key":
            return "You need to change the 'Shared Secret Key' to your Shared Secret!"
        
        decoded_shared_secret = base64.b64decode(shared_secret)
        time_hash = self.create_time_hash(self.get_steam_time(True))
        hmac_result = self.create_hmac(time_hash, decoded_shared_secret)
        hmac_result = self.start_array_to_zero(hmac_result)
        
        b = self.int_to_byte(hmac_result[19] & 0xF)
        code_point = ((hmac_result[b] & 0x7F) << 24 | 
                      (hmac_result[b + 1] & 0xFF) << 16 | 
                      (hmac_result[b + 2] & 0xFF) << 8 | 
                      (hmac_result[b + 3] & 0xFF))
        
        steam_chars = "23456789BCDFGHJKMNPQRTVWXY"
        code = ""
        for i in range(5):
            code += steam_chars[int(code_point) % len(steam_chars)]
            code_point /= len(steam_chars)
        
        return code

def main():
    # 检查命令行参数
    if len(sys.argv) != 2:
        print("Usage: python script.py <shared_secret>")
        return
    
    shared_secret = sys.argv[1]
    auth = SteamAuth()
    code = auth.generate_steam_guard_code(shared_secret)
    print(f"{code}")

if __name__ == "__main__":
    main()
