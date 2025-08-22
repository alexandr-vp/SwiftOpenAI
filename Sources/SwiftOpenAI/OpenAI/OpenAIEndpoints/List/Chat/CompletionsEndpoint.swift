import Foundation

struct CompletionsEndpoint: Endpoint {
    private let model: OpenAIModelType
    private let optionalParameters: CompletionsOptionalParameters?

    var method: HTTPMethod {
        .POST
    }

    var path: String = "completions"

    init(model: OpenAIModelType,
         optionalParameters: CompletionsOptionalParameters?) {
        self.model = model
        self.optionalParameters = optionalParameters
    }

    var parameters: [String: Any]? {
        ["model": self.model.name as Any,
         "prompt": self.optionalParameters?.prompt as Any,
         "suffix": self.optionalParameters?.suffix as Any,
         (model.name.hasPrefix("gpt-5") ? "max_completion_tokens" : "max_tokens"): (model.name.hasPrefix("gpt-5") ? nil : self.optionalParameters?.maxTokens as Any),
         "temperature": (model.name.hasPrefix("gpt-5") ? 1 : (self.optionalParameters?.temperature as Any)),
         "top_p": self.optionalParameters?.topP as Any,
         "n": self.optionalParameters?.n as Any,
         "logprobs": self.optionalParameters?.logprobs as Any,
         "echo": self.optionalParameters?.echo as Any,
         "stop": self.optionalParameters?.stop as Any,
         "presence_penalty": self.optionalParameters?.presencePenalty as Any,
         "frequency_penalty": self.optionalParameters?.frequencyPenalty as Any,
         "best_of": self.optionalParameters?.bestOf as Any,
         "user": self.optionalParameters?.user as Any
        ]
    }
}
