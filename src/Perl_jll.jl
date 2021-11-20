# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule Perl_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("Perl")
JLLWrappers.@generate_main_file("Perl", UUID("83958c19-0796-5285-893e-a1267f8ec499"))
end  # module Perl_jll
