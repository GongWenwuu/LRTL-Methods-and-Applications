% ��չĿ������ ten,����ά�� k չ��,���ؾ���
function mat = ten2mat(ten,k) % ����չ��Ϊ����
dim = size(ten);
% Tensor unfolding for tensor with size of n1*n2*...*nd
% dim = (n1,n2,...,nd), k=1,2,...,d
redim = permute(ten,[k,1:k-1,k+1:length(dim)]); % ���¶�������ten��ά�ȣ�������ֵ��δ�����ı�
mat = reshape(redim,dim(k),[]);