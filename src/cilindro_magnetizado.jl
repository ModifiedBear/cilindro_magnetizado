module cilindro_magnetizado
export potential_in, potential_out

using LegendrePolynomials
#using RedefStructs

function B(z::Float64, μ₀::Float64,M::Float64,L::Float64,R::Float64)
  # Magnetic Field function
  return μ₀*M*( (z + L)/sqrt(1.0 + ( (z + L)/R )^2 ) - 
                (z - L)/sqrt(1.0 + ( (z - L)/R )^2 ) );
end

function ψ(z::Float64, μ₀::Float64,M::Float64,L::Float64,R::Float64)
  # Magnetic potential function
  return μ₀*M*( sqrt( R^2 + (z - L)^2) 
              - sqrt( R^2 + (z + L)^2 ) ) * 0.5;
end

function PLsmin(r::Float64,θ::Float64,n::Int64,μ₀::Float64,
                M::Float64,L::Float64,R::Float64)
  # Legendre Polynomial expansion for inside 
  # the radius of convergence
  vit = 1:2:2*n-1
  s = 0.0
  for l in vit
    s = s + μ₀*M*sqrt(R^2+L^2)*
                 Pl(L/sqrt(R^2+L^2),l)*
                 Pl(cos(θ),l)*((r/sqrt(R^2+L^2))^l)*
                 ( ((r/sqrt(R^2+L^2))^2)*(1/(2*l+3)) - 
                             (1/(2*l-1)) )
  end
    
  return s
end

function PLsmout(r::Float64,θ::Float64,n::Int64, 
                μ₀::Float64,M::Float64,L::Float64,R::Float64)
  # Legendre Polynomial expansion for outside 
  # the radius of convergence
  vit = 1:2:2*n-1
  s = 0.0
  for l in vit
    s = s + μ₀*M*(sqrt(R^2+L^2)^l)*Pl(L/sqrt(R^2+L^2),l)*
      Pl(cos(θ),l)*(1/(r^l))*( (R^2+L^2)/((2*l+3)*r) - r/(2*l-1) )
  end
  
  
  return s
end

function potential_in()
  # get expansion for inside radius
  
  # Constants
  μ₀ = 4π*1E-07;
  M = 1.0*1E+04;
  R = 0.01;
  L = 0.02;
  
  parts = 101; #Domain's sub-parts
  
  rin   = LinRange(0,sqrt(R^2+L^2),parts);
  # rout  = LinRange(sqrt(R^2+L^2),4*sqrt(R^2+L^2),parts);
  θ     = LinRange(0,pi,parts);
  # zin   = LinRange(-sqrt(R^2+L^2),sqrt(R^2+L^2),parts);
  # zmout = LinRange(-4*sqrt(R^2+L^2),-sqrt(R^2+L^2),parts);
  # zpout = LinRange(sqrt(R^2+L^2),4*sqrt(R^2+L^2),parts);
  
  # xspin  = [ r*sin(θ) for r in rin,  θ in θ ];
  # xsmin  = [-r*sin(θ) for r in rin,  θ in θ ];
  # xspout = [ r*sin(θ) for r in rout, θ in θ ];
  # xsmout = [-r*sin(θ) for r in rout, θ in θ ];
  # zsin   = [ r*cos(θ) for r in rin,  θ in θ ];
  # zsout  = [ r*cos(θ) for r in rout, θ in θ ];
  
  return [PLsmin( r,θ,20,μ₀,M,L,R) for r in rin,  θ in θ];
end

function potential_out()
  # get expansion for outside radius

  # Constants
  μ₀ = 4π*1E-07;
  M = 1.0*1E+04;
  R = 0.01;
  L = 0.02;
  
  parts = 101; #Domain's sub-parts
  
  rout  = LinRange(sqrt(R^2+L^2),4*sqrt(R^2+L^2),parts);
  θ     = LinRange(0,pi,parts);
  # zmout = LinRange(-4*sqrt(R^2+L^2),-sqrt(R^2+L^2),parts);
  # zpout = LinRange(sqrt(R^2+L^2),4*sqrt(R^2+L^2),parts);
  
  
  # xspin  = [ r*sin(θ) for r in rin,  θ in θ ];
  # xsmin  = [-r*sin(θ) for r in rin,  θ in θ ];
  # xspout = [ r*sin(θ) for r in rout, θ in θ ];
  # xsmout = [-r*sin(θ) for r in rout, θ in θ ];
  # zsin   = [ r*cos(θ) for r in rin,  θ in θ ];
  # zsout  = [ r*cos(θ) for r in rout, θ in θ ];
  
  return [PLsmout(r,θ,20,μ₀,M,L,R) for r in rout, θ in θ];
end

end # module cilindro_magnetizado
