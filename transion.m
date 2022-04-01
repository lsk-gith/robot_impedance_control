function T_fin = transion(q1,q2,q3,q4,q5,q6)
%TRANSION
%    T_FIN = TRANSION(Q1,Q2,Q3,Q4,Q5,Q6)

%    This function was generated by the Symbolic Math Toolbox version 8.6.
%    15-Jan-2022 16:02:22

t2 = cos(q1);
t3 = cos(q2);
t4 = cos(q3);
t5 = cos(q4);
t6 = cos(q5);
t7 = cos(q6);
t8 = sin(q1);
t9 = sin(q2);
t10 = sin(q3);
t11 = sin(q4);
t12 = sin(q5);
t13 = sin(q6);
t14 = t2.*t3;
t15 = t3.*t4;
t16 = t2.*t6;
t17 = t2.*t9;
t18 = t3.*t8;
t19 = t3.*t10;
t20 = t4.*t9;
t21 = t2.*t12;
t22 = t6.*t8;
t23 = t8.*t9;
t24 = t9.*t10;
t25 = t8.*t12;
t42 = t2.*6.123233995736766e-17;
t43 = t6.*6.123233995736766e-17;
t44 = t8.*6.123233995736766e-17;
t45 = t12.*6.123233995736766e-17;
t26 = -t23;
t27 = -t24;
t28 = -t25;
t29 = t19+t20;
t46 = -t42;
t47 = t14.*6.123233995736766e-17;
t48 = t17.*6.123233995736766e-17;
t49 = t18.*6.123233995736766e-17;
t50 = t23.*6.123233995736766e-17;
t30 = t15+t27;
t31 = t5.*t29;
t32 = t11.*t29;
t51 = -t50;
t52 = t17+t49;
t53 = t18+t48;
t55 = t26+t47;
t33 = t5.*t30;
t34 = t11.*t30;
t35 = -t32;
t54 = t14+t51;
t56 = t10.*t52;
t57 = t10.*t53;
t58 = t4.*t52;
t59 = t4.*t53;
t62 = t10.*t55;
t63 = t4.*t55;
t36 = -t33;
t37 = t31+t34;
t38 = t33+t35;
t60 = t10.*t54;
t61 = t4.*t54;
t65 = -t63;
t70 = t59+t62;
t39 = t6.*t37;
t40 = t12.*t37;
t64 = -t61;
t66 = t6.*(t32+t36).*(-6.123233995736766e-17);
t67 = t12.*(t32+t36).*(-6.123233995736766e-17);
t68 = t58+t60;
t69 = t32+t36+3.749399456654644e-33;
t72 = t57+t65;
t75 = t5.*t70;
t76 = t11.*t70;
t41 = -t40;
t71 = t56+t64;
t73 = t5.*t68;
t74 = t11.*t68;
t79 = t5.*t72;
t80 = t11.*t72;
t83 = t39+t45+t67;
t77 = t5.*t71;
t78 = t11.*t71;
t82 = -t80;
t84 = t41+t43+t66;
t87 = t76+t79;
t81 = -t78;
t85 = t74+t77;
t90 = t75+t82;
t96 = t12.*t87.*6.123233995736766e-17;
t98 = t6.*t87.*6.123233995736766e-17;
t99 = t46+t87;
t86 = t73+t81;
t88 = t6.*t85;
t89 = t12.*t85;
t91 = t6.*t90;
t92 = t12.*t90;
t93 = -t91;
t94 = t44+t86;
t95 = t45.*t86;
t97 = t43.*t86;
t100 = t6.*t86.*(-6.123233995736766e-17);
t103 = t16+t92+t98;
t101 = t22+t89+t100;
t102 = t28+t88+t95;
t104 = t21+t93+t96;
T_fin = reshape([-t13.*t94+t13.*(t22+t89-t97).*6.123233995736766e-17-t7.*(-t25+t88+t12.*t86.*6.123233995736766e-17),t13.*t103.*(-6.123233995736766e-17)-t7.*(t21+t93+t45.*t87)+t13.*(t42-t87),-t13.*t69+t7.*t83-t13.*(t40-t43+t43.*(t32+t36)).*6.123233995736766e-17,0.0,-t7.*t94+t7.*(t22+t89-t97).*6.123233995736766e-17+t13.*(-t25+t88+t12.*t86.*6.123233995736766e-17),t7.*t103.*(-6.123233995736766e-17)+t13.*(t21+t93+t45.*t87)+t7.*(t42-t87),-t7.*t69-t13.*t83-t7.*(t40-t43+t43.*(t32+t36)).*6.123233995736766e-17,0.0,t8.*3.749399456654644e-33+t73.*6.123233995736766e-17-t78.*6.123233995736766e-17+t101,t2.*(-3.749399456654644e-33)-t16+t76.*6.123233995736766e-17+t79.*6.123233995736766e-17-t92-t43.*t87,t32.*6.123233995736766e-17-t33.*6.123233995736766e-17+t84+2.295845021658468e-49,0.0,t8.*1.105e-1-t14.*(3.0./1.0e+1)+t22.*(4.1e+1./5.0e+2)+t23.*1.83697019872103e-17+t56.*(6.9e+1./2.5e+2)-t61.*(6.9e+1./2.5e+2)+t73.*9.000000000000001e-2-t78.*9.000000000000001e-2+t89.*(4.1e+1./5.0e+2)-t6.*t86.*5.021051876504148e-18,t2.*(-1.105e-1)-t16.*(4.1e+1./5.0e+2)-t17.*1.83697019872103e-17-t18.*(3.0./1.0e+1)-t59.*(6.9e+1./2.5e+2)-t62.*(6.9e+1./2.5e+2)+t76.*9.000000000000001e-2+t79.*9.000000000000001e-2-t92.*(4.1e+1./5.0e+2)-t6.*t87.*5.021051876504148e-18,t6.*5.021051876504148e-18-t9.*(3.0./1.0e+1)-t19.*(6.9e+1./2.5e+2)-t20.*(6.9e+1./2.5e+2)+t32.*9.000000000000001e-2-t33.*9.000000000000001e-2-t40.*(4.1e+1./5.0e+2)-t6.*(t32+t36).*5.021051876504148e-18+1.215e-1,1.0],[4,4]);