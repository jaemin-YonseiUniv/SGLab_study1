function y0 = ang_init(Kp,Po,Vo,E,Xg,wo)

    syms x;
    Eq = wo*Kp*(Po - 1.5*E*Vo*sin(x)/Xg);
    
    S = solve(Eq,x,'ReturnConditions',true);
    y0 = S
end