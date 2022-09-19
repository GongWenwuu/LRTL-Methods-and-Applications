% ԭͼ�� Image,��Ϊ���õ������� K,ȱʧ���� known
function X2 = SiLRTC(Image,K,known)
tic; % ��ʱ��
imSize = size(Image); % ���������ά�ȴ�С������������

% Corrupting Image
X = zeros(imSize); % ����ȫ�����飬ȫ��ȱʧ
X = double(ReplaceInd(X,known,Image,imSize)); % ReplaceInd������ʵ��ֵ�滻ȫ����󣬱�֤Omegaָ����������ֵ��ͬ������ȱʧ����X 

% Create random alphas and betas
b = abs(randn(3,1))/200; % �㷨�еĳ���������,randn���������������
a = abs(randn(3,1));
a = a./sum(a); % ��׼��

% Block Coordinate Decent Algorithm
for k = 1:K % Iteration step
    M = zeros(imSize); % initialize Mi's
    for i = 1:3 
        % Create Mi's multiply by appropriate beta value fold them and add into tensor to get Mi values 
        % M = M + Mfold(b(i)*shrinkage(unfold(X,i),a(i)/b(i)),i,imSize);
        M = M + Mfold(b(i)*shrinkage(ten2mat(X,i),a(i)/b(i)),i,imSize); % The closed form of convex problem,��ȱʧ��������X�ĺ���
    end
    % Divide by sum of betas
    M = M./sum(b); % ���������Ԫ�ض�Ӧ��������ڷ�ĸ����ֵ��˵�����û�����𣬸���ȱʧֵ�µ�����X

    % Update indices that we know from Image into M and set X equal to M
    M = ReplaceInd(M,known,Image,imSize); % Image ��Ӧ������ʵ���ݣ���ֵ���ֲ��䣬M�ǲ��Ͻ��е������³�����(Convex closed form)
    X = M; % BCD �ֿ��㷨�ĸ��¹���
end
% Output Absolute Value Error Image
imwrite(uint8(abs(double(Image)-double(X))),'SiError.jpg')
X2 = X;
toc;
end