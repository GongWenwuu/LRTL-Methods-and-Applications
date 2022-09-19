% ������� a����������ά�� i,Ŀ��������ά�� OrDim,����һ�����ܵ�����(folding)
function c = Mfold(a,i,OrDim) % �Ծ��� a ���� i ά����ϳ���ά����
c = [];
for j = 1:OrDim(i) 
    switch i % switch-case ��䣬��ʾ���ղ�ͬά������
        case 1
            c(j,:,:) = reshape(a(j,:),OrDim(2),OrDim(3));
        case 2
            c(:,j,:) = reshape(a(j,:),OrDim(1),OrDim(3));
        case 3
            c(:,:,j) = reshape(a(j,:),OrDim(1),OrDim(2));
    end
end
end