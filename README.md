# NimABKDecrypt

Decrypting App Bound Keys With Nim.


## Requirements
To compile this successfully, You'll need some nimble libraries installed:

```
nimble install winim
nimble install ptr_math
nimble install cligen
```

## Usage
```
$ decrypt.exe -h
Usage:
  main [REQUIRED,optional-params] [args: string...]
Options:
  -h, --help                             print this cligen-erated help
  --help-syntax                          advanced: prepend,plurals,..
  -b=, --browserType=  string  REQUIRED  set browserType
```

## Example
Decrypting the user's Chrome App Bound Key:

```
$ decrypt.exe --browser chrome
[+] Decrypted Key: 980f8ea8af3299d966a26242.....
```

## Credits
[Chrome App Bound Encryption Decryption](https://github.com/xaitax/Chrome-App-Bound-Encryption-Decryption) by [Xaitax](https://github.com/xaitax/), I implemented it the same way he did but with a few tweaks and simplifications. 
