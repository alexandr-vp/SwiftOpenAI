import Foundation

public enum OpenAIModelType {
    case gpt4o(GPT4o)
    case gpt4(GPT4)
    case gpt3_5(GPT3_5)
    case embedding(EmbeddingModel)
    case custom(String)

    var name: String {
        switch self {
        case .gpt4o(let gpt4oModel):
            return gpt4oModel.rawValue
        case .gpt4(let gpt4Model):
            return gpt4Model.rawValue
        case .gpt3_5(let gpt3_5Model):
            return gpt3_5Model.rawValue
        case .embedding(let embeddingModel):
            return embeddingModel.rawValue
        case .custom(let model):
            return model
        }
    }
}

public enum OpenAIImageModelType {
    case dalle(Dalle)

    var name: String {
        switch self {
        case .dalle(let model):
            return model.rawValue
        }
    }
}

public enum GPT4o: String {
    case base = "gpt-4o"
    case gpt_4o_2024_05_13 = "gpt-4o-2024-05-13"
}

public enum GPT4: String {
    case base = "gpt-4-turbo"
    case gpt_4_turbo_2024_04_09 = "gpt-4-turbo-2024-04-09"
    case gpt_4 = "gpt-4"
    case gpt_4_turbo_preview = "gpt-4-turbo-preview"
    case gpt_4_0125_preview = "gpt-4-0125-preview"
    case gpt_4_1106_preview = "gpt-4-1106-preview"
    case gpt_4_1106_vision_preview = "gpt-4-1106-vision-preview"
    case gpt_4_vision_preview = "gpt-4-vision-preview"
    case gpt_4_32k = "gpt-4-32k"
    case gpt_4_0613 = "gpt-4-0613"
    case gpt_4_32k_0613 = "gpt-4-32k-0613"
}

public enum GPT3_5: String {
    case turbo = "gpt-3.5-turbo"
    case gpt_3_5_turbo_0125 = "gpt-3.5-turbo-0125"
    case gpt_3_5_turbo_1106 = "gpt-3.5-turbo-1106"
    case gpt_3_5_turbo_instruct = "gpt-3.5-turbo-instruct"
}

public enum Dalle: String {
    case dalle2 = "dall-e-2"
    case dalle3 = "dall-e-3"
}

public enum EmbeddingModel: String {
    case text_embedding_ada_002 = "text-embedding-ada-002"
    case text_embedding_3_small = "text-embedding-3-small"
    case text_embedding_3_large = "text-embedding-3-large"
}
