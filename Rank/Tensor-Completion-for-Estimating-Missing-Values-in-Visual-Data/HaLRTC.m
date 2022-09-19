% ԭͼ�� Image,��Ϊ���õ������� K,ȱʧ���� known
function X2 = HaLRTC(Image,K,known)
tic;
% assuming image is 3 dimensional
imSize = size(Image);

% Corrupting Image
X = zeros(imSize);
X = double(ReplaceInd(X,known,Image,imSize));

% Setup alpha and rho values
a = abs(randn(3,1));
a = a./sum(a);
p = 1e-6; % ��ʼ��������ֵ

% Create tensor holders for Mi and Yi done to simplify variable storage
ArrSize = [imSize,ndims(Image)]; % ndims ���������ά������ά����
Mi = zeros(ArrSize);
Yi = zeros(ArrSize);
K = K - 10;

% ADMM Algorithm
for k = 1:K
    % Calculate Mi tensors (Step 1)
    for i = 1:3
        % ten2mat(squeeze(Yi(:,:,:,i)),i) squeeze ��������άѹ��Ϊ��ά����
        Mi(:,:,:,i) = Mfold(shrinkage(ten2mat(X,i) + ten2mat(squeeze(Yi(:,:,:,i)),i)./p,a(i)/p),i,imSize); % ADMM ����ʾ��
    end

    % Update X (Step 2)
    X = (sum(Mi-Yi./p,4))/3; % Ӧ��sum������֤���յ���ά����ͣ�������X���и���
    X = ReplaceInd(X,known,Image,imSize);

    % Update Yi tensors (Step 3)
    for i = 1:ArrSize(length(ArrSize))
        Yi(:,:,:,i) =  squeeze(Yi(:,:,:,i))-p*(squeeze(Mi(:,:,:,i))-X);
    end

    % Modify rho to help convergence
    p = 1.2*p; % �����������ϸ���
end
% Output Image
% imwrite(uint8(X),'HaFinal.jpg')
% imshow(uint8(X));
% Output Absolute Value Error Image
imwrite(uint8(abs(double(Image)-double(X))),'HaError.jpg')
X2 = X;
toc;
end