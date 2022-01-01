function [intersectionPoint1,intersectionPoint2] = intersect3Spheres(Ca,Cb,Cc,Ra,Rb,Rc)
kA = Ra^2 - (Ca(1)^2+Ca(2)^2+Ca(3)^2);
kB = Rb^2 - (Cb(1)^2+Cb(2)^2+Cb(3)^2);
kC = Rc^2 - (Cc(1)^2+Cc(2)^2+Cc(3)^2);
kab = (kA-kB)/2;
kac = (kA-kC)/2; 
kbc = (kB-kC)/2; 

Xab = Cb(1)-Ca(1);
Xac = Cc(1)-Ca(1);
Xbc = Cc(1)-Cb(1);
Yab = Cb(2)-Ca(2);
Yac = Cc(2)-Ca(2);
Ybc = Cc(2)-Cb(2);
Zab = Cb(3)-Ca(3);
Zac = Cc(3)-Ca(3);
Zbc = Cc(3)-Cb(3);

%esfera : x^2 + y^2 + z^2 - 2*(Ca(1)*x + Ca(2)*y + Ca(3)*z) = kA

caso = 0;
if Yab 
    if Yac
        if Zab
            caso = 1;  %Yab, Yac, Zab != 0
        else
            if Zac
                caso = 1; %1  %Yab, Yac, Zac != 0
            else
                if Xab
                    caso = 3; %3  %Zab, Zac == 0; Xab !=0
                else
                    if Xac
                        caso = 3; %3  %Zab, Zac == 0; Xac !=0
                    else
                        if Zbc
                            caso = 6; %6  %Zab, Zac, Xac, Xab == 0
                        else
                            if Xbc
                                caso = 7; %7
                            else
                                %ERROR
                            end
                        end
                    end
                end
            end
        end
    else
        if Zab
            if Zac
                caso = 1; %1
            else
                if Xac
                    caso = 5; %5
                else
                    %ERROR
                end
            end
        else
            if Zac
                caso = 1; %1
            else
                if Xac
                    caso = 3; %3
                else
                    %ERROR
                end
            end
        end
    end
else
    if Yac
        if Zab
           caso = 1; %1
        else
            if Zac
                if Xab
                    if Xac
                        caso = 4; %4
                    else
                        caso = 4; %4
                    end
                else
                    %ERROR
                end
            else
                if Xab
                    caso = 3; %3
                else
                    %ERROR
                end
            end
        end
    else
        if Zab
            if Zac
                if Xab
                    caso = 2; %2
                else
                    if Xac
                        caso = 2; %2
                    else
                        if Ybc
                            caso = 8; %8
                        else
                            if Xbc
                                caso = 9; %9
                            else
                                %ERROR
                            end
                        end
                    end
                end
            else
                if Xac
                    caso = 5; %5
                else
                   %ERROR
                end
            end
        else
            if Zac
                if Xab
                    caso = 4; %4
                else
                    %ERROR
                end
            else
                if Zbc
                    caso = 10; %10
                else
                    if Ybc
                        caso = 11; %11
                    else
                        %ERROR
                    end
                end
            end
        end
    end
end
            
%x^2 + y^2 + z^2 - 2*(Ca(1)*x + Ca(2)*y + Ca(3)*z) = kA
%Xab*x + Yab*y + Zab*z == kab 
%Xac*x + Yac*y + Zac*z == kac

switch caso 
    case 1
        x1 = (Yab*Zac*(Xab^2*Yac^2*Ca(3)^2 + kA*Xab^2*Yac^2 - 2*Xab^2*Yac*Zac*Ca(2)*Ca(3) + 2*Xab^2*Yac*kac*Ca(2) + Xab^2*Zac^2*Ca(2)^2 + kA*Xab^2*Zac^2 + 2*Xab^2*Zac*kac*Ca(3) - Xab^2*kac^2 - 2*Xab*Xac*Yab*Yac*Ca(3)^2 - 2*kA*Xab*Xac*Yab*Yac + 2*Xab*Xac*Yab*Zac*Ca(2)*Ca(3) - 2*Xab*Xac*Yab*kac*Ca(2) + 2*Xab*Xac*Yac*Zab*Ca(2)*Ca(3) - 2*Xab*Xac*Yac*kab*Ca(2) - 2*Xab*Xac*Zab*Zac*Ca(2)^2 - 2*kA*Xab*Xac*Zab*Zac - 2*Xab*Xac*Zab*kac*Ca(3) - 2*Xab*Xac*Zac*kab*Ca(3) + 2*Xab*Xac*kab*kac + 2*Xab*Yab*Yac*Zac*Ca(1)*Ca(3) - 2*Xab*Yab*Yac*kac*Ca(1) - 2*Xab*Yab*Zac^2*Ca(1)*Ca(2) - 2*Xab*Yac^2*Zab*Ca(1)*Ca(3) + 2*Xab*Yac^2*kab*Ca(1) + 2*Xab*Yac*Zab*Zac*Ca(1)*Ca(2) - 2*Xab*Zab*Zac*kac*Ca(1) + 2*Xab*Zac^2*kab*Ca(1) + Xac^2*Yab^2*Ca(3)^2 + kA*Xac^2*Yab^2 - 2*Xac^2*Yab*Zab*Ca(2)*Ca(3) + 2*Xac^2*Yab*kab*Ca(2) + Xac^2*Zab^2*Ca(2)^2 + kA*Xac^2*Zab^2 + 2*Xac^2*Zab*kab*Ca(3) - Xac^2*kab^2 - 2*Xac*Yab^2*Zac*Ca(1)*Ca(3) + 2*Xac*Yab^2*kac*Ca(1) + 2*Xac*Yab*Yac*Zab*Ca(1)*Ca(3) - 2*Xac*Yab*Yac*kab*Ca(1) + 2*Xac*Yab*Zab*Zac*Ca(1)*Ca(2) - 2*Xac*Yac*Zab^2*Ca(1)*Ca(2) + 2*Xac*Zab^2*kac*Ca(1) - 2*Xac*Zab*Zac*kab*Ca(1) + Yab^2*Zac^2*Ca(1)^2 + kA*Yab^2*Zac^2 + 2*Yab^2*Zac*kac*Ca(3) - Yab^2*kac^2 - 2*Yab*Yac*Zab*Zac*Ca(1)^2 - 2*kA*Yab*Yac*Zab*Zac - 2*Yab*Yac*Zab*kac*Ca(3) - 2*Yab*Yac*Zac*kab*Ca(3) + 2*Yab*Yac*kab*kac - 2*Yab*Zab*Zac*kac*Ca(2) + 2*Yab*Zac^2*kab*Ca(2) + Yac^2*Zab^2*Ca(1)^2 + kA*Yac^2*Zab^2 + 2*Yac^2*Zab*kab*Ca(3) - Yac^2*kab^2 + 2*Yac*Zab^2*kac*Ca(2) - 2*Yac*Zab*Zac*kab*Ca(2) - Zab^2*kac^2 + 2*Zab*Zac*kab*kac - Zac^2*kab^2)^(1/2) - Yac*Zab*(Xab^2*Yac^2*Ca(3)^2 + kA*Xab^2*Yac^2 - 2*Xab^2*Yac*Zac*Ca(2)*Ca(3) + 2*Xab^2*Yac*kac*Ca(2) + Xab^2*Zac^2*Ca(2)^2 + kA*Xab^2*Zac^2 + 2*Xab^2*Zac*kac*Ca(3) - Xab^2*kac^2 - 2*Xab*Xac*Yab*Yac*Ca(3)^2 - 2*kA*Xab*Xac*Yab*Yac + 2*Xab*Xac*Yab*Zac*Ca(2)*Ca(3) - 2*Xab*Xac*Yab*kac*Ca(2) + 2*Xab*Xac*Yac*Zab*Ca(2)*Ca(3) - 2*Xab*Xac*Yac*kab*Ca(2) - 2*Xab*Xac*Zab*Zac*Ca(2)^2 - 2*kA*Xab*Xac*Zab*Zac - 2*Xab*Xac*Zab*kac*Ca(3) - 2*Xab*Xac*Zac*kab*Ca(3) + 2*Xab*Xac*kab*kac + 2*Xab*Yab*Yac*Zac*Ca(1)*Ca(3) - 2*Xab*Yab*Yac*kac*Ca(1) - 2*Xab*Yab*Zac^2*Ca(1)*Ca(2) - 2*Xab*Yac^2*Zab*Ca(1)*Ca(3) + 2*Xab*Yac^2*kab*Ca(1) + 2*Xab*Yac*Zab*Zac*Ca(1)*Ca(2) - 2*Xab*Zab*Zac*kac*Ca(1) + 2*Xab*Zac^2*kab*Ca(1) + Xac^2*Yab^2*Ca(3)^2 + kA*Xac^2*Yab^2 - 2*Xac^2*Yab*Zab*Ca(2)*Ca(3) + 2*Xac^2*Yab*kab*Ca(2) + Xac^2*Zab^2*Ca(2)^2 + kA*Xac^2*Zab^2 + 2*Xac^2*Zab*kab*Ca(3) - Xac^2*kab^2 - 2*Xac*Yab^2*Zac*Ca(1)*Ca(3) + 2*Xac*Yab^2*kac*Ca(1) + 2*Xac*Yab*Yac*Zab*Ca(1)*Ca(3) - 2*Xac*Yab*Yac*kab*Ca(1) + 2*Xac*Yab*Zab*Zac*Ca(1)*Ca(2) - 2*Xac*Yac*Zab^2*Ca(1)*Ca(2) + 2*Xac*Zab^2*kac*Ca(1) - 2*Xac*Zab*Zac*kab*Ca(1) + Yab^2*Zac^2*Ca(1)^2 + kA*Yab^2*Zac^2 + 2*Yab^2*Zac*kac*Ca(3) - Yab^2*kac^2 - 2*Yab*Yac*Zab*Zac*Ca(1)^2 - 2*kA*Yab*Yac*Zab*Zac - 2*Yab*Yac*Zab*kac*Ca(3) - 2*Yab*Yac*Zac*kab*Ca(3) + 2*Yab*Yac*kab*kac - 2*Yab*Zab*Zac*kac*Ca(2) + 2*Yab*Zac^2*kab*Ca(2) + Yac^2*Zab^2*Ca(1)^2 + kA*Yac^2*Zab^2 + 2*Yac^2*Zab*kab*Ca(3) - Yac^2*kab^2 + 2*Yac*Zab^2*kac*Ca(2) - 2*Yac*Zab*Zac*kab*Ca(2) - Zab^2*kac^2 + 2*Zab*Zac*kab*kac - Zac^2*kab^2)^(1/2) + Yab^2*Zac^2*Ca(1) + Yac^2*Zab^2*Ca(1) + Xab*Yac^2*kab + Xac*Yab^2*kac + Xab*Zac^2*kab + Xac*Zab^2*kac - Xab*Yab*Zac^2*Ca(2) - Xac*Yac*Zab^2*Ca(2) - Xab*Yac^2*Zab*Ca(3) - Xac*Yab^2*Zac*Ca(3) - Xab*Yab*Yac*kac - Xac*Yab*Yac*kab - Xab*Zab*Zac*kac - Xac*Zab*Zac*kab + Xab*Yab*Yac*Zac*Ca(3) + Xab*Yac*Zab*Zac*Ca(2) + Xac*Yab*Yac*Zab*Ca(3) + Xac*Yab*Zab*Zac*Ca(2) - 2*Yab*Yac*Zab*Zac*Ca(1))/(Xab^2*Yac^2 + Xab^2*Zac^2 - 2*Xab*Xac*Yab*Yac - 2*Xab*Xac*Zab*Zac + Xac^2*Yab^2 + Xac^2*Zab^2 + Yab^2*Zac^2 - 2*Yab*Yac*Zab*Zac + Yac^2*Zab^2);
        x2 = (Yac*Zab*(Xab^2*Yac^2*Ca(3)^2 + kA*Xab^2*Yac^2 - 2*Xab^2*Yac*Zac*Ca(2)*Ca(3) + 2*Xab^2*Yac*kac*Ca(2) + Xab^2*Zac^2*Ca(2)^2 + kA*Xab^2*Zac^2 + 2*Xab^2*Zac*kac*Ca(3) - Xab^2*kac^2 - 2*Xab*Xac*Yab*Yac*Ca(3)^2 - 2*kA*Xab*Xac*Yab*Yac + 2*Xab*Xac*Yab*Zac*Ca(2)*Ca(3) - 2*Xab*Xac*Yab*kac*Ca(2) + 2*Xab*Xac*Yac*Zab*Ca(2)*Ca(3) - 2*Xab*Xac*Yac*kab*Ca(2) - 2*Xab*Xac*Zab*Zac*Ca(2)^2 - 2*kA*Xab*Xac*Zab*Zac - 2*Xab*Xac*Zab*kac*Ca(3) - 2*Xab*Xac*Zac*kab*Ca(3) + 2*Xab*Xac*kab*kac + 2*Xab*Yab*Yac*Zac*Ca(1)*Ca(3) - 2*Xab*Yab*Yac*kac*Ca(1) - 2*Xab*Yab*Zac^2*Ca(1)*Ca(2) - 2*Xab*Yac^2*Zab*Ca(1)*Ca(3) + 2*Xab*Yac^2*kab*Ca(1) + 2*Xab*Yac*Zab*Zac*Ca(1)*Ca(2) - 2*Xab*Zab*Zac*kac*Ca(1) + 2*Xab*Zac^2*kab*Ca(1) + Xac^2*Yab^2*Ca(3)^2 + kA*Xac^2*Yab^2 - 2*Xac^2*Yab*Zab*Ca(2)*Ca(3) + 2*Xac^2*Yab*kab*Ca(2) + Xac^2*Zab^2*Ca(2)^2 + kA*Xac^2*Zab^2 + 2*Xac^2*Zab*kab*Ca(3) - Xac^2*kab^2 - 2*Xac*Yab^2*Zac*Ca(1)*Ca(3) + 2*Xac*Yab^2*kac*Ca(1) + 2*Xac*Yab*Yac*Zab*Ca(1)*Ca(3) - 2*Xac*Yab*Yac*kab*Ca(1) + 2*Xac*Yab*Zab*Zac*Ca(1)*Ca(2) - 2*Xac*Yac*Zab^2*Ca(1)*Ca(2) + 2*Xac*Zab^2*kac*Ca(1) - 2*Xac*Zab*Zac*kab*Ca(1) + Yab^2*Zac^2*Ca(1)^2 + kA*Yab^2*Zac^2 + 2*Yab^2*Zac*kac*Ca(3) - Yab^2*kac^2 - 2*Yab*Yac*Zab*Zac*Ca(1)^2 - 2*kA*Yab*Yac*Zab*Zac - 2*Yab*Yac*Zab*kac*Ca(3) - 2*Yab*Yac*Zac*kab*Ca(3) + 2*Yab*Yac*kab*kac - 2*Yab*Zab*Zac*kac*Ca(2) + 2*Yab*Zac^2*kab*Ca(2) + Yac^2*Zab^2*Ca(1)^2 + kA*Yac^2*Zab^2 + 2*Yac^2*Zab*kab*Ca(3) - Yac^2*kab^2 + 2*Yac*Zab^2*kac*Ca(2) - 2*Yac*Zab*Zac*kab*Ca(2) - Zab^2*kac^2 + 2*Zab*Zac*kab*kac - Zac^2*kab^2)^(1/2) - Yab*Zac*(Xab^2*Yac^2*Ca(3)^2 + kA*Xab^2*Yac^2 - 2*Xab^2*Yac*Zac*Ca(2)*Ca(3) + 2*Xab^2*Yac*kac*Ca(2) + Xab^2*Zac^2*Ca(2)^2 + kA*Xab^2*Zac^2 + 2*Xab^2*Zac*kac*Ca(3) - Xab^2*kac^2 - 2*Xab*Xac*Yab*Yac*Ca(3)^2 - 2*kA*Xab*Xac*Yab*Yac + 2*Xab*Xac*Yab*Zac*Ca(2)*Ca(3) - 2*Xab*Xac*Yab*kac*Ca(2) + 2*Xab*Xac*Yac*Zab*Ca(2)*Ca(3) - 2*Xab*Xac*Yac*kab*Ca(2) - 2*Xab*Xac*Zab*Zac*Ca(2)^2 - 2*kA*Xab*Xac*Zab*Zac - 2*Xab*Xac*Zab*kac*Ca(3) - 2*Xab*Xac*Zac*kab*Ca(3) + 2*Xab*Xac*kab*kac + 2*Xab*Yab*Yac*Zac*Ca(1)*Ca(3) - 2*Xab*Yab*Yac*kac*Ca(1) - 2*Xab*Yab*Zac^2*Ca(1)*Ca(2) - 2*Xab*Yac^2*Zab*Ca(1)*Ca(3) + 2*Xab*Yac^2*kab*Ca(1) + 2*Xab*Yac*Zab*Zac*Ca(1)*Ca(2) - 2*Xab*Zab*Zac*kac*Ca(1) + 2*Xab*Zac^2*kab*Ca(1) + Xac^2*Yab^2*Ca(3)^2 + kA*Xac^2*Yab^2 - 2*Xac^2*Yab*Zab*Ca(2)*Ca(3) + 2*Xac^2*Yab*kab*Ca(2) + Xac^2*Zab^2*Ca(2)^2 + kA*Xac^2*Zab^2 + 2*Xac^2*Zab*kab*Ca(3) - Xac^2*kab^2 - 2*Xac*Yab^2*Zac*Ca(1)*Ca(3) + 2*Xac*Yab^2*kac*Ca(1) + 2*Xac*Yab*Yac*Zab*Ca(1)*Ca(3) - 2*Xac*Yab*Yac*kab*Ca(1) + 2*Xac*Yab*Zab*Zac*Ca(1)*Ca(2) - 2*Xac*Yac*Zab^2*Ca(1)*Ca(2) + 2*Xac*Zab^2*kac*Ca(1) - 2*Xac*Zab*Zac*kab*Ca(1) + Yab^2*Zac^2*Ca(1)^2 + kA*Yab^2*Zac^2 + 2*Yab^2*Zac*kac*Ca(3) - Yab^2*kac^2 - 2*Yab*Yac*Zab*Zac*Ca(1)^2 - 2*kA*Yab*Yac*Zab*Zac - 2*Yab*Yac*Zab*kac*Ca(3) - 2*Yab*Yac*Zac*kab*Ca(3) + 2*Yab*Yac*kab*kac - 2*Yab*Zab*Zac*kac*Ca(2) + 2*Yab*Zac^2*kab*Ca(2) + Yac^2*Zab^2*Ca(1)^2 + kA*Yac^2*Zab^2 + 2*Yac^2*Zab*kab*Ca(3) - Yac^2*kab^2 + 2*Yac*Zab^2*kac*Ca(2) - 2*Yac*Zab*Zac*kab*Ca(2) - Zab^2*kac^2 + 2*Zab*Zac*kab*kac - Zac^2*kab^2)^(1/2) + Yab^2*Zac^2*Ca(1) + Yac^2*Zab^2*Ca(1) + Xab*Yac^2*kab + Xac*Yab^2*kac + Xab*Zac^2*kab + Xac*Zab^2*kac - Xab*Yab*Zac^2*Ca(2) - Xac*Yac*Zab^2*Ca(2) - Xab*Yac^2*Zab*Ca(3) - Xac*Yab^2*Zac*Ca(3) - Xab*Yab*Yac*kac - Xac*Yab*Yac*kab - Xab*Zab*Zac*kac - Xac*Zab*Zac*kab + Xab*Yab*Yac*Zac*Ca(3) + Xab*Yac*Zab*Zac*Ca(2) + Xac*Yab*Yac*Zab*Ca(3) + Xac*Yab*Zab*Zac*Ca(2) - 2*Yab*Yac*Zab*Zac*Ca(1))/(Xab^2*Yac^2 + Xab^2*Zac^2 - 2*Xab*Xac*Yab*Yac - 2*Xab*Xac*Zab*Zac + Xac^2*Yab^2 + Xac^2*Zab^2 + Yab^2*Zac^2 - 2*Yab*Yac*Zab*Zac + Yac^2*Zab^2);
        y1 = -(Zab*kac - Zac*kab + Xab*Zac*x1 - Xac*Zab*x1)/(Yab*Zac - Yac*Zab);
        y2 = -(Zab*kac - Zac*kab + Xab*Zac*x2 - Xac*Zab*x2)/(Yab*Zac - Yac*Zab);
        z1 = (Yab*kac - Yac*kab + Xab*Yac*x1 - Xac*Yab*x1)/(Yab*Zac - Yac*Zab);
        z2 = (Yab*kac - Yac*kab + Xab*Yac*x2 - Xac*Yab*x2)/(Yab*Zac - Yac*Zab);
    case 2
        x1 = (kab*Zac - kac*Zab)/(Xab*Zac - Xac*Zab);
        x2 = x1;
        z1 = (kab*Xac - kac*Xab)/(Zab*Xac - Zac*Xab);
        z2 = z1;
        y1 = Ca(2) - (- x1^2 + 2*Ca(1)*x1 + Ca(2)^2 - z1^2 + 2*Ca(3)*z1 + kA)^(1/2);
        y2 = Ca(2) + (- x1^2 + 2*Ca(1)*x1 + Ca(2)^2 - z1^2 + 2*Ca(3)*z1 + kA)^(1/2);
    case 3
        x1 = (kab*Yac - kac*Yab)/(Xab*Yac - Xac*Yab);
        x2 = x1;
        y1 = (kab*Xac - kac*Xab)/(Yab*Xac - Yac*Xab);
        y2 = y1;
        z1 = Ca(3) - (- x1^2 + 2*Ca(1)*x1 - y1^2 + 2*Ca(2)*y1 + Ca(3)^2 + kA)^(1/2);
        z2 = Ca(3) + (- x1^2 + 2*Ca(1)*x1 - y1^2 + 2*Ca(2)*y1 + Ca(3)^2 + kA)^(1/2);
    case 4
        x1 = kab/Xab;
        x2 = x1;
        y1 = (Zac*(- Xab^2*Yac^2*x1^2 + 2*Ca(1)*Xab^2*Yac^2*x1 + Xab^2*Yac^2*Ca(3)^2 + kA*Xab^2*Yac^2 - 2*Xab^2*Yac*Zac*Ca(2)*Ca(3) + 2*Xab^2*Yac*kac*Ca(2) - Xab^2*Zac^2*x1^2 + 2*Ca(1)*Xab^2*Zac^2*x1 + Xab^2*Zac^2*Ca(2)^2 + kA*Xab^2*Zac^2 + 2*Xab^2*Zac*kac*Ca(3) - Xab^2*kac^2 - 2*Xab*Xac*Yac*kab*Ca(2) - 2*Xab*Xac*Zac*kab*Ca(3) + 2*Xab*Xac*kab*kac - Xac^2*kab^2)^(1/2) + Xab*Yac*kac - Xac*Yac*kab + Xab*Zac^2*Ca(2) - Xab*Yac*Zac*Ca(3))/(Xab*(Yac^2 + Zac^2));
        y2 = -(Zac*(- Xab^2*Yac^2*x1^2 + 2*Ca(1)*Xab^2*Yac^2*x1 + Xab^2*Yac^2*Ca(3)^2 + kA*Xab^2*Yac^2 - 2*Xab^2*Yac*Zac*Ca(2)*Ca(3) + 2*Xab^2*Yac*kac*Ca(2) - Xab^2*Zac^2*x1^2 + 2*Ca(1)*Xab^2*Zac^2*x1 + Xab^2*Zac^2*Ca(2)^2 + kA*Xab^2*Zac^2 + 2*Xab^2*Zac*kac*Ca(3) - Xab^2*kac^2 - 2*Xab*Xac*Yac*kab*Ca(2) - 2*Xab*Xac*Zac*kab*Ca(3) + 2*Xab*Xac*kab*kac - Xac^2*kab^2)^(1/2) - Xab*Yac*kac + Xac*Yac*kab - Xab*Zac^2*Ca(2) + Xab*Yac*Zac*Ca(3))/(Xab*(Yac^2 + Zac^2));
        z1 = (kac - Xac/Xab*kab - Yac*y1)/Zac;
        z2 = (kac - Xac/Xab*kab - Yac*y2)/Zac;
    case 5
        x1 = kac/Xac;
        x2 = x1;
        y1 =  (Zab*(- Xab^2*kac^2 - 2*Xab*Xac*Yab*kac*Ca(2) - 2*Xab*Xac*Zab*kac*Ca(3) + 2*Xab*Xac*kab*kac - Xac^2*Yab^2*x1^2 + 2*Ca(1)*Xac^2*Yab^2*x1 + Xac^2*Yab^2*Ca(3)^2 + kA*Xac^2*Yab^2 - 2*Xac^2*Yab*Zab*Ca(2)*Ca(3) + 2*Xac^2*Yab*kab*Ca(2) - Xac^2*Zab^2*x1^2 + 2*Ca(1)*Xac^2*Zab^2*x1 + Xac^2*Zab^2*Ca(2)^2 + kA*Xac^2*Zab^2 + 2*Xac^2*Zab*kab*Ca(3) - Xac^2*kab^2)^(1/2) - Xab*Yab*kac + Xac*Yab*kab + Xac*Zab^2*Ca(2) - Xac*Yab*Zab*Ca(3))/(Xac*(Yab^2 + Zab^2));
        y2 = -(Zab*(- Xab^2*kac^2 - 2*Xab*Xac*Yab*kac*Ca(2) - 2*Xab*Xac*Zab*kac*Ca(3) + 2*Xab*Xac*kab*kac - Xac^2*Yab^2*x1^2 + 2*Ca(1)*Xac^2*Yab^2*x1 + Xac^2*Yab^2*Ca(3)^2 + kA*Xac^2*Yab^2 - 2*Xac^2*Yab*Zab*Ca(2)*Ca(3) + 2*Xac^2*Yab*kab*Ca(2) - Xac^2*Zab^2*x1^2 + 2*Ca(1)*Xac^2*Zab^2*x1 + Xac^2*Zab^2*Ca(2)^2 + kA*Xac^2*Zab^2 + 2*Xac^2*Zab*kab*Ca(3) - Xac^2*kab^2)^(1/2) + Xab*Yab*kac - Xac*Yab*kab - Xac*Zab^2*Ca(2) + Xac*Yab*Zab*Ca(3))/(Xac*(Yab^2 + Zab^2));
        z1 = (kab - Xab/Xac*kac - Yab*y1)/Zab;
        z2 = (kab - Xab/Xac*kac - Yab*y2)/Zab;
    case 6
        y1 = kab/Yab;
        y2 = y1;
        x1 = (Xbc*kbc + Zbc*(- Xbc^2*y1^2 + 2*Ca(2)*Xbc^2*y1 + Xbc^2*Ca(3)^2 + kA*Xbc^2 - 2*Xbc*Ybc*Ca(1)*y1 - 2*Xbc*Zbc*Ca(1)*Ca(3) + 2*Xbc*kbc*Ca(1) - Ybc^2*y1^2 - 2*Ybc*Zbc*y1*Ca(3) + 2*Ybc*kbc*y1 + Zbc^2*Ca(1)^2 - Zbc^2*y1^2 + 2*Ca(2)*Zbc^2*y1 + kA*Zbc^2 + 2*Zbc*kbc*Ca(3) - kbc^2)^(1/2) + Zbc^2*Ca(1) - Xbc*Ybc*y1 - Xbc*Zbc*Ca(3))/(Xbc^2 + Zbc^2);
        x2 = -(Zbc*(- Xbc^2*y1^2 + 2*Ca(2)*Xbc^2*y1 + Xbc^2*Ca(3)^2 + kA*Xbc^2 - 2*Xbc*Ybc*Ca(1)*y1 - 2*Xbc*Zbc*Ca(1)*Ca(3) + 2*Xbc*kbc*Ca(1) - Ybc^2*y1^2 - 2*Ybc*Zbc*y1*Ca(3) + 2*Ybc*kbc*y1 + Zbc^2*Ca(1)^2 - Zbc^2*y1^2 + 2*Ca(2)*Zbc^2*y1 + kA*Zbc^2 + 2*Zbc*kbc*Ca(3) - kbc^2)^(1/2) - Xbc*kbc - Zbc^2*Ca(1) + Xbc*Ybc*y1 + Xbc*Zbc*Ca(3))/(Xbc^2 + Zbc^2);
        z1 = (kbc - Ybc*y1 - Xbc*x1)/Zbc;
        z2 = (kbc - Ybc*y2 - Xbc*x2)/Zbc;
    case 7
        y1 = kab/Yab;
        y2 = y1;
        x1 = (kbc - Ybc*y1)/Xbc;
        x2 = x1;
        z1 = Ca(3) - (- x1^2 + 2*Ca(1)*x1 - y1^2 + 2*Ca(2)*y1 + Ca(3)^2 + kA)^(1/2);
        z2 = Ca(3) + (- x1^2 + 2*Ca(1)*x1 - y1^2 + 2*Ca(2)*y1 + Ca(3)^2 + kA)^(1/2);
    case 8
        z1 = kab/Zab;
        z2 = z1;
        x1 = (Xbc*kbc + Ybc*(Xbc^2*Ca(2)^2 - Xbc^2*z1^2 + 2*Ca(3)*Xbc^2*z1 + kA*Xbc^2 - 2*Xbc*Ybc*Ca(1)*Ca(2) - 2*Xbc*Zbc*Ca(1)*z1 + 2*Xbc*kbc*Ca(1) + Ybc^2*Ca(1)^2 - Ybc^2*z1^2 + 2*Ca(3)*Ybc^2*z1 + kA*Ybc^2 - 2*Ybc*Zbc*Ca(2)*z1 + 2*Ybc*kbc*Ca(2) - Zbc^2*z1^2 + 2*Zbc*kbc*z1 - kbc^2)^(1/2) + Ybc^2*Ca(1) - Xbc*Ybc*Ca(2) - Xbc*Zbc*z1)/(Xbc^2 + Ybc^2);
        x2 = -(Ybc*(Xbc^2*Ca(2)^2 - Xbc^2*z1^2 + 2*Ca(3)*Xbc^2*z1 + kA*Xbc^2 - 2*Xbc*Ybc*Ca(1)*Ca(2) - 2*Xbc*Zbc*Ca(1)*z1 + 2*Xbc*kbc*Ca(1) + Ybc^2*Ca(1)^2 - Ybc^2*z1^2 + 2*Ca(3)*Ybc^2*z1 + kA*Ybc^2 - 2*Ybc*Zbc*Ca(2)*z1 + 2*Ybc*kbc*Ca(2) - Zbc^2*z1^2 + 2*Zbc*kbc*z1 - kbc^2)^(1/2) - Xbc*kbc - Ybc^2*Ca(1) + Xbc*Ybc*Ca(2) + Xbc*Zbc*z1)/(Xbc^2 + Ybc^2);
        y1 = (kbc - Zbc*z1 - Xbc*x1)/Ybc;
        y2 = (kbc - Zbc*z2 - Xbc*x2)/Ybc;
    case 9
        z1 = kab/Zab;
        z2 = z1;
        x1 = (kbc -Zbc*z1)/Xbc;
        x2 = (kbc -Zbc*z2)/Xbc;
        y1 = Ca(2) - (- x1^2 + 2*Ca(1)*x1 + Ca(2)^2 - z1^2 + 2*Ca(3)*z1 + kA)^(1/2);
        y2 = Ca(2) + (- x1^2 + 2*Ca(1)*x1 + Ca(2)^2 - z1^2 + 2*Ca(3)*z1 + kA)^(1/2);
    case 10
        x1 = kab/Xab;
        x2 = x1;
        y1 = (Ybc*kbc + Zbc*(- Xbc^2*x1^2 - 2*Xbc*Ybc*x1*Ca(2) - 2*Xbc*Zbc*x1*Ca(3) + 2*Xbc*kbc*x1 - Ybc^2*x1^2 + 2*Ca(1)*Ybc^2*x1 + Ybc^2*Ca(3)^2 + kA*Ybc^2 - 2*Ybc*Zbc*Ca(2)*Ca(3) + 2*Ybc*kbc*Ca(2) - Zbc^2*x1^2 + 2*Ca(1)*Zbc^2*x1 + Zbc^2*Ca(2)^2 + kA*Zbc^2 + 2*Zbc*kbc*Ca(3) - kbc^2)^(1/2) + Zbc^2*Ca(2) - Xbc*Ybc*x1 - Ybc*Zbc*Ca(3))/(Ybc^2 + Zbc^2);
        y2 = -(Zbc*(- Xbc^2*x1^2 - 2*Xbc*Ybc*x1*Ca(2) - 2*Xbc*Zbc*x1*Ca(3) + 2*Xbc*kbc*x1 - Ybc^2*x1^2 + 2*Ca(1)*Ybc^2*x1 + Ybc^2*Ca(3)^2 + kA*Ybc^2 - 2*Ybc*Zbc*Ca(2)*Ca(3) + 2*Ybc*kbc*Ca(2) - Zbc^2*x1^2 + 2*Ca(1)*Zbc^2*x1 + Zbc^2*Ca(2)^2 + kA*Zbc^2 + 2*Zbc*kbc*Ca(3) - kbc^2)^(1/2) - Ybc*kbc - Zbc^2*Ca(2) + Xbc*Ybc*x1 + Ybc*Zbc*Ca(3))/(Ybc^2 + Zbc^2);
        z1 = (kbc - Xbc*x1 - Ybc*y1)/Zbc;
        z2 = (kbc - Xbc*x2 - Ybc*y2)/Zbc;
    case 11
        x1 = kab/Xab;
        x2 = x1;
        y1 = (kbc - Xbc*x1)/Ybc;
        y2 = y1;
        z1 = Ca(3) - (- x1^2 + 2*Ca(1)*x1 - y1^2 + 2*Ca(2)*y1 + Ca(3)^2 + kA)^(1/2);
        z2 = Ca(3) + (- x1^2 + 2*Ca(1)*x1 - y1^2 + 2*Ca(2)*y1 + Ca(3)^2 + kA)^(1/2);
    otherwise
        disp('No solution found');
        x1 = NaN;
        x2 = NaN;
        y1 = NaN;
        y2 = NaN;
        z1 = NaN;
        z2 = NaN;
end   

   intersectionPoint1 = [x1 y1 z1];
   intersectionPoint2 = [x2 y2 z2];
   
end

