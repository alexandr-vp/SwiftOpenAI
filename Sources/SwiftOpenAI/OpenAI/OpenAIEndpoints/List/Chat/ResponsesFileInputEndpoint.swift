import Foundation

struct ResponsesFileInputEndpoint: Endpoint {
    private let model: OpenAIModelType
    private var messages: [[String: Any]] = []

    private let optionalParameters: ChatCompletionsOptionalParameters?

    var method: HTTPMethod {
        .POST
    }

    var path: String = "responses"

    init(model: OpenAIModelType,
         messages: [MessageChatGPT],
         optionalParameters: ChatCompletionsOptionalParameters?) {
        self.model = model
        self.messages = Self.mapMessageModelToDictionary(messages: messages)
        self.optionalParameters = optionalParameters
    }

    var parameters: [String: Any]? {
        ["model": self.model.name as Any,
         "input": self.messages as Any,
         "temperature": (model.name.hasPrefix("gpt-5") ? 1 : (self.optionalParameters?.temperature as Any)),
         "top_p": self.optionalParameters?.topP as Any,
         "n": self.optionalParameters?.n as Any,
         "stop": self.optionalParameters?.stop as Any,
         "stream": self.optionalParameters?.stream as Any,
         (model.name.hasPrefix("gpt-5") ? "max_completion_tokens" : "max_tokens"): (model.name.hasPrefix("gpt-5") ? nil : self.optionalParameters?.maxTokens as Any)]
    }

    private static func mapMessageModelToDictionary(messages: [MessageChatGPT]) -> [[String: Any]] {
        return messages.map { message in
            if let fileURL = message.fileURL {
                var contentArray: [[String: Any]] = []
                contentArray.append(["type": "input_text", "text": message.text])
                contentArray.append(["type": "input_file", "file_url": fileURL])
                return ["role": message.role.rawValue, "content": contentArray]
            } else {
                return ["role": message.role.rawValue, "content": message.text]
            }
        }
    }
}
