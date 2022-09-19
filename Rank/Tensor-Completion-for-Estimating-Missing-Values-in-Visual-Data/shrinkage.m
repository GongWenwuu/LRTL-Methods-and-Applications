% ���� X, �ضϲ��� t,����ѹ������
function D = shrinkage(X,t) % ��SVD�ֽ����������ƣ������µ�����D
[U,Sig,V] = svd(X,'econ'); % ����X SVD�ֽ�
for i = 1:size(Sig,1)
    Sig(i,i) = max(Sig(i,i)-t,0); % ���ɶԽ���
end
D = U*Sig*V';
end