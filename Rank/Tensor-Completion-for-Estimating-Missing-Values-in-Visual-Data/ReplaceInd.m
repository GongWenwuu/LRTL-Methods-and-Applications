% ���� X,���ȱʧ���� Known,ȱʧ�������� Image,������С imSize,����X���º������
function mOut = ReplaceInd(X,known,Image,imSize) % ������X��������滻(�������)��������ɲ�������known����
for i = 1:length(known)
    [in1,in2] = FindInd(known(i),imSize);
    X(in1,in2,:) = double(Image(in1,in2,:)); % ��Ϊȱʧ��
end
mOut = X;
end