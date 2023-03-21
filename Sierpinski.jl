using PlotlyJS

struct Δ
    p1  :: Vector{Real}
    p2  :: Vector{Real}
    p3  :: Vector{Real}
end

function Affine(S)
    f = Set([])
    for t in S
        # For each triangle in the set, create three new ones
        
        v = [0.5 0;0 0.5]
        ξ = [0;0]
        t1 = Δ(v*t.p1 + ξ, v*t.p2 + ξ, v*t.p3 + ξ)
        
        ξ = [0.5;0]
        t2 = Δ(v*t.p1 + ξ, v*t.p2 + ξ, v*t.p3 + ξ)
        
        ξ = [0.25;0.5]
        t3 = Δ(v*t.p1 + ξ, v*t.p2 + ξ, v*t.p3 + ξ)
        
        f = f ∪ Set([t1,t2,t3])
    end
    
    return f
end

function doPlot(S)
    x = []
    y = []
    
    for t in S
        push!(x,t.p1[1])
        push!(x,t.p2[1])
        push!(x,t.p3[1])
        push!(x,nothing)
        push!(y,t.p1[2])
        push!(y,t.p2[2])
        push!(y,t.p3[2])
        push!(y,nothing)
    end
    
    p = plot(scatter(x=x,y=y,fill="toself"))
    return p
end

t = Δ([0.0;0.0],[1.0;0.0],[0.5,1.0])
So = Set([t])
S1 = Affine(So)
S2 = Affine(S1)
S3 = Affine(S2)

p = doPlot(S3)
#p = plot(scatter(x=[t.p1[1],t.p2[1],t.p3[1]],y=[t.p1[2],t.p2[2],t.p3[2]],fill="toself"))
display(p)
readline()
