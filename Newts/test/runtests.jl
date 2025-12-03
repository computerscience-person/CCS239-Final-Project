using Newts
using Test

@testset "evaluating polynomial functions" begin
    @test evaluate_at([2, -1, 5, -3, 7], -2) == 160
end
