import Foundation

struct ChatCompletionsImageInputEndpoint: Endpoint {
    private let model: OpenAIModelType
    private var messages: [[String: Any]] = []

    private let optionalParameters: ChatCompletionsOptionalParameters?

    var method: HTTPMethod {
        .POST
    }

    var path: String = "chat/completions"

    init(model: OpenAIModelType,
         messages: [MessageChatImageInput],
         optionalParameters: ChatCompletionsOptionalParameters?) {
        self.model = model
        self.messages = Self.mapMessageModelToDictionary(messages: messages)
        self.optionalParameters = optionalParameters
    }

    var parameters: [String: Any]? {
        ["model": self.model.name as Any,
         "messages": self.messages as Any,
         "temperature": (model.name.hasPrefix("gpt-5") ? 1 : (self.optionalParameters?.temperature as Any)),
         "top_p": self.optionalParameters?.topP as Any,
         "n": self.optionalParameters?.n as Any,
         "stop": self.optionalParameters?.stop as Any,
         "stream": self.optionalParameters?.stream as Any,
         (model.name.hasPrefix("gpt-5") ? "max_completion_tokens" : "max_tokens"): (model.name.hasPrefix("gpt-5") ? nil : self.optionalParameters?.maxTokens as Any)]
    }

    private static func mapMessageModelToDictionary(messages: [MessageChatImageInput]) -> [[String: Any]] {
        return messages.map { message in
            var contentArray: [[String: Any]] = []
            contentArray.append(["type": "text", "text": message.text])

            if !message.imageURL.isEmpty {
                contentArray.append(["type": "image_url", "image_url": ["url": message.imageURL]])
            }

            return ["role": message.role.rawValue, "content": contentArray]
        }
    }
}
