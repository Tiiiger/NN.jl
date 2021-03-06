include("../src/layers/LayerBase.jl")
include("../src/layers/ReLu.jl")
import Calculus: check_gradient
using Base.Test

l = ReLu()
function beforeTest(l)
    init(l, nothing, Dict{String, Any}("batch_size" => 1, "input_size" => [3]))
end


function testReLuOneVector(x, y, dldy, dldx; alpha = 1.)
    beforeTest(l)

    # Testing forwarding
    @test forward(l,x) == y
    @test l.x == x
    @test l.y == y

    #Testing back propagation
    @test backward(l,dldy) == dldx
    @test l.dldy == dldy
    @test l.dldx == dldx
end

# First Test
println("Unit test 1...")
x = [1. 0. 0.5;]
y = [1. 0. 0.5;]
dldy = [1. 2. 3.;]
dldx = [1. 0. 3.;]
testReLuOneVector(x, y, dldy, dldx)
println("test 1 passed.\n")

# Second Test
println("Unit test 2...")
x2 = [-2. 3. -0.5;]
y2 = [0. 3. 0.;]
dldy2 = [0. 1. 3.;]
dldx2 = [0. 1. 0.;]
testReLuOneVector(x2, y2, dldy2, dldx2)
println("test 2 passed.\n")

# Third test
println("Unit test 3...")
x  = [1. 1. 1.;]
y  = [1. 1. 1.;]
dldy = [-2. -3 -4;]
dldx = [-2. -3 -4;]
testReLuOneVector(x, y, dldy, dldx)
println("test 3 passed.\n")
