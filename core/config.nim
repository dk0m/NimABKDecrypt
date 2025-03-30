import winim/mean

type
    BrowserConfig* = object
     clsid*: CLSID
     iid*: IID
     localState*: string

const
    KEY_SIZE* = 32

    CHROME_CONFIG* = BrowserConfig(
        clsid: DEFINE_GUID("708860e0-f641-4611-8895-7d867dd3675b"),
        iid: DEFINE_GUID("463abecf-410d-407f-8af5-0df35a005cc8"),
        localState: "\\Google\\Chrome\\User Data\\Local State"
    )

    BRAVE_CONFIG* = BrowserConfig(
        clsid: DEFINE_GUID("576b31af-6369-4b6b-8560-e4b203a97a8b"),
        iid: DEFINE_GUID("f396861e-0c8e-4c71-8256-2fae6d759ce9"),
        localState: "\\BraveSoftware\\Brave-Browser\\User Data\\Local State"
    )

    EDGE_CONFIG* = BrowserConfig(
        clsid: DEFINE_GUID("1fcbe96c-1697-43af-9140-2897c7c69767"),
        iid: DEFINE_GUID("c9c2b807-7731-4f34-81b7-44ff7779522b"),
        localState: "\\Microsoft\\Edge\\User Data\\Local State"
    )