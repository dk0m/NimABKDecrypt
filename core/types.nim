import winim/mean

type

  ProtectionLevel* {.pure.} = enum
    None = 0
    PathValidationOld = 1
    PathValidation = 2
    Max = 3
  
  IElevator* {.pure.} = object
    lpVtbl*: ptr IElevatorVtbl
  
  IElevatorVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    RunRecoveryCRXElevated*: proc(self: ptr IElevator, crxPath: PWCHAR, browserAppId: PWCHAR, browserVersion: PWCHAR, sessionId: PWCHAR, callerProcId: DWORD, procHandle: ptr ULONG_PTR): HRESULT {.stdcall.}
    EncryptData*: proc(self: ptr IElevator, protectionLevel: ProtectionLevel, plainText: BSTR, cipherText: ptr BSTR, lastError: ptr DWORD): HRESULT {.stdcall.}
    DecryptData*: proc(self: ptr IElevator, cipherText: BSTR, plainText: ptr BSTR, lastError: ptr DWORD): HRESULT {.stdcall.}

proc RunRecoveryCRXElevated*(self: ptr IElevator, crxPath: PWCHAR, browserAppId: PWCHAR, browserVersion: PWCHAR, sessionId: PWCHAR, callerProcId: DWORD, procHandle: ptr ULONG_PTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RunRecoveryCRXElevated(self, crxPath, browserAppId, browserVersion, sessionId, callerProcId, procHandle)
proc EncryptData*(self: ptr IElevator, protectionLevel: ProtectionLevel, plainText: BSTR, cipherText: ptr BSTR, lastError: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.EncryptData(self, protectionLevel, plainText, cipherText, lastError)

proc DecryptData*(self: ptr IElevator, cipherText: BSTR, plainText: ptr BSTR, lastError: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DecryptData(self, cipherText, plainText, lastError)
