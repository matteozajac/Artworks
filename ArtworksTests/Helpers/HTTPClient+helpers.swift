import Foundation

func anyData(_ text: String = "any data") -> Data {
    Data(text.utf8)
}

func anyUrl() -> URL {
    URL(string: "https://any.url")!
}

func anyResponse(_ statusCode: Int) -> HTTPURLResponse {
    HTTPURLResponse(url: anyUrl(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}

func anyRequest() -> URLRequest {
    URLRequest(url: anyUrl())
}

func anyHttpResult(_ text: String) -> (Data, URLResponse) {
    return (anyData(text), anyResponse(200))
}
