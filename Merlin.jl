push!(LOAD_PATH, pwd() * "/Core")
push!(LOAD_PATH, pwd() * "/Core/Event")
push!(LOAD_PATH, pwd() * "/Core/Lib")

import Pkg
Pkg.precompile()

include("Core/Application.jl")