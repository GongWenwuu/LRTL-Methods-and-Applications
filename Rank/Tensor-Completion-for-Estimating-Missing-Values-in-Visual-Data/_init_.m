% ������
clear all;
rng('shuffle') % �������������
KnownPercentage = 50; % ͼ����֪����
Image = imread('good_brother.jpg');

% ����һ��ȱʧ����
Image = double(Image); 
imSize = size(Image);
known = randperm(prod(imSize)/imSize(3),floor(KnownPercentage/100*(prod(imSize)/imSize(3)))); % randperm, ����û��������������ȱʧ���ݵ��±꣬����������
X = zeros(imSize);
X = double(ReplaceInd(X,known,Image,imSize));
imwrite(uint8(X),'Simulated_Data.jpg')

% SiLRTC�㷨���
X1 = SiLRTC(Image,100,known); % ��Ϊ���õ�������,����255�� 
imwrite(uint8(X1),'SiLRTC_Result.jpg');

% HaLRTC�㷨���
X1 = HaLRTC(Image,50,known); % ��Ϊ���õ�������,����108��
imwrite(uint8(X1),'HaLRTC_Result.jpg');

% FaLRTC�㷨���
X1 = FaLRTC(Image,50,known);  % ��Ϊ���õ�������,����166��
imwrite(uint8(X1),'FaLRTC_Result.jpg');

subplot(2,2,1)
imshow('good_brother.jpg');
title('Original Image');
subplot(2,2,2)
imshow('Simulated_Data.jpg');
title('Simulated Image');
subplot(2,2,3)
imshow('FaLRTC_Result.jpg');
title('FaLRTC Image');
subplot(2,2,4)
imshow('FaError.jpg');
title('Error Image');

            

