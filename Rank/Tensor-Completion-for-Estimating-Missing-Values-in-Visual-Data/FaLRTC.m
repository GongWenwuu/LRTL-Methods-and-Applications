% ԭͼ�� Image,��Ϊ���õ������� K,ȱʧ���� known
function X2 = FaLRTC(Image,K,known)
tic;

imSize = size(Image);
X = zeros(imSize);
X = double(ReplaceInd(X,known,Image,imSize));

% Create needed constants and holder variables
a = abs(randn(3,1));
a = a./sum(a);
C = 0.5;
u = 10^5;
ui = a./u;
Z = X;
W = X;
B = 0;
L = sum(ui);

for k = 0:K
    while true
        Theta = (1+sqrt(1+4*L*B)) / (2*L);
        W = Theta/(B+Theta) * Z + B/(B+Theta) * X;

        % Compute f(x), f(w) and f'(w).
        dfw = zeros(imSize);
        fx = 0;
        fw = 0;

        for i = 1:3
            [Sig,~] = Trimming(ten2mat(X,i),ui(i)/a(i));
            fx = fx + sum(Sig(:));
            [Sig,T] = Trimming(ten2mat(W,i),ui(i)/a(i));
            fw = fw + sum(Sig(:));
            dfw = dfw + Mfold(a(i)^2/ui(i)*T,i,imSize); % ���������
        end
        dfw = ReplaceInd(dfw,known,zeros(imSize),imSize); % ÿ��ѭ���ݶȵĸ��£�ȱʧ���ݲ�ȫ�ĺ��Ĳ���

        % If step size is too low then break
        if fx <= fw - sum(dfw(:).^2)/L
            break;
        end

        % Solve for new f(X) using modified W matrix
        Xp = W - dfw/L; % �����߶�����в������£�ʹ������Xp���� (һ��ѭ��)
        fxp = 0;
        for i = 1:3
            [Sig,~] = Trimming(ten2mat(Xp,i),ui(i)/a(i));
            fxp = fxp + sum(Sig(:));
        end

        % If step size is not too large update and break
        if fxp <= fw - sum(dfw(:).^2)/2/L
            X = Xp; % ����ѭ�����������ز�ȫ������X
            break;
        end

        % Update L and rerun ѭ����������������
        L = L/C; 
        if L == Inf
            disp('Error')
            imwrite(uint8(X),'FaFinal.jpg') % If L is too large throw error and exit
            exit
        end
        
    end
    
    % Update Z and B ��һ��ѭ����ʼ
    Z = Z - Theta*dfw;
    B = B + Theta;
    
end
% Output Image
% imwrite(uint8(X),'FaFinal.jpg')
%Output Absolute Value Error Image
imwrite(uint8(abs(double(Image)-double(X))),'FaError.jpg')
X2 = X;

toc;
end
