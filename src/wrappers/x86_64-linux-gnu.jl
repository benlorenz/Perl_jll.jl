# Autogenerated wrapper script for Perl_jll for x86_64-linux-gnu
export libperl, perl

using Readline_jll
## Global variables
PATH = ""
LIBPATH = ""
LIBPATH_env = "LD_LIBRARY_PATH"
LIBPATH_default = ""

# Relative path to `libperl`
const libperl_splitpath = ["lib", "libperl.so"]

# This will be filled out by __init__() for all products, as it must be done at runtime
libperl_path = ""

# libperl-specific global declaration
# This will be filled out by __init__()
libperl_handle = C_NULL

# This must be `const` so that we can use it with `ccall()`
const libperl = "libperl.so"


# Relative path to `perl`
const perl_splitpath = ["bin", "perl"]

# This will be filled out by __init__() for all products, as it must be done at runtime
perl_path = ""

# perl-specific global declaration
function perl(f::Function; adjust_PATH::Bool = true, adjust_LIBPATH::Bool = true)
    global PATH, LIBPATH
    env_mapping = Dict{String,String}()
    if adjust_PATH
        if !isempty(get(ENV, "PATH", ""))
            env_mapping["PATH"] = string(PATH, ':', ENV["PATH"])
        else
            env_mapping["PATH"] = PATH
        end
    end
    if adjust_LIBPATH
        LIBPATH_base = get(ENV, LIBPATH_env, expanduser(LIBPATH_default))
        if !isempty(LIBPATH_base)
            env_mapping[LIBPATH_env] = string(LIBPATH, ':', LIBPATH_base)
        else
            env_mapping[LIBPATH_env] = LIBPATH
        end
    end
    withenv(env_mapping...) do
        f(perl_path)
    end
end


"""
Open all libraries
"""
function __init__()
    global artifact_dir = abspath(artifact"Perl")

    # Initialize PATH and LIBPATH environment variable listings
    global PATH_list, LIBPATH_list
    # From the list of our dependencies, generate a tuple of all the PATH and LIBPATH lists,
    # then append them to our own.
    foreach(p -> append!(PATH_list, p), (Readline_jll.PATH_list,))
    foreach(p -> append!(LIBPATH_list, p), (Readline_jll.LIBPATH_list,))

    global libperl_path = normpath(joinpath(artifact_dir, libperl_splitpath...))

    # Manually `dlopen()` this right now so that future invocations
    # of `ccall` with its `SONAME` will find this path immediately.
    global libperl_handle = dlopen(libperl_path)
    push!(LIBPATH_list, dirname(libperl_path))

    global perl_path = normpath(joinpath(artifact_dir, perl_splitpath...))

    push!(PATH_list, dirname(perl_path))
    # Filter out duplicate and empty entries in our PATH and LIBPATH entries
    filter!(!isempty, unique!(PATH_list))
    filter!(!isempty, unique!(LIBPATH_list))
    global PATH = join(PATH_list, ':')
    global LIBPATH = join(vcat(LIBPATH_list, [joinpath(Sys.BINDIR, Base.LIBDIR, "julia"), joinpath(Sys.BINDIR, Base.LIBDIR)]), ':')
end  # __init__()

