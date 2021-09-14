push!(LOAD_PATH, pwd() * "/Core")
push!(LOAD_PATH, pwd() * "/Core/Event")
push!(LOAD_PATH, pwd() * "/Core/Lib")

# Precompile packages
import Pkg
Pkg.precompile()

# Load environment variables
using ConfigEnv
dotenv()

# Include main application
include("Core/Application.jl")
Application.Run()