% num һάλ������,mSize ������С,���ؾ���������Ϣ
function [a,b] = FindInd(num,mSize) % ����Folding����һάindex�ҵ�ԭ�ȶ�ά�����index
a = ceil(num/mSize(2)); % ����ȡ��
b = mSize(1) - mod(num,mSize(1)); % mod, ȡ������
end