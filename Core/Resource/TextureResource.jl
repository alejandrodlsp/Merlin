using Base:String
using FileIO
using ColorTypes
using FixedPointNumbers

struct TextureData <: ResourceData
    path::String
    data::Matrix{ColorTypes.RGBA{FixedPointNumbers.N0f8}}
end

function Texture_Load(texture_path)::TextureData
    if (ResPool_Exists(texture_path))
        return ResPool_Get(texture_path)
    end

    data = load(texture_path)
    texture_data = TextureData(texture_path, data)
    ResPool_Register(texture_path, texture_data)
    texture_data
end

function Texture_Unload(texture_path)
    ResPool_Unregister(texture_path)
end