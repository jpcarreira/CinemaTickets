/**
 By defining the ApiType as a protocol we can implement different concretizations of this protocol,
 one being the "real api" (which would connect to the production API) and the one can be a MockAPI
 (where we can fake network requests)
 */
protocol ApiType { }


final class Api: ApiType { }


final class MockApi: ApiType { }
