close all,clear,clc
addpath('..\edison_matlab_interface\');


SpatialBandwidth =6; 
 RangeBandwidth =4.5; 
 MinimumRegionArea = 100; 
 
 path = 'E:\Study\CVPR2015NEW\Dataset\RGB\';
 
  DepthMat_list = dir(strcat(path,'*.jpg'));%��ȡ���ļ���������jpg��ʽ��ͼ��
    mat_num = length(DepthMat_list);%��ȡͼ��������


    tr=0;
    for j = 1:mat_num %��һ��ȡͼ��

         img_name = DepthMat_list(j).name;% ͼ����  
 
         ImgIndex = img_name(1:end-4);
              fprintf('%d %s\n',j,strcat(path,img_name));% ��ʾ���ڴ����ͼ����
              
              
         Img=imread(strcat(path,ImgIndex,'.jpg')); 
              
              
 [fimage labels modes regSize]=edison_wrapper(Img,@RGB2Lab,'SpatialBandWidth',SpatialBandwidth,...
     'RangeBandWidth',RangeBandwidth,'MinimumRegionArea',MinimumRegionArea,'synergistic',true,...
     'EdgeStrengthThreshold',0.1);
 
  B=[1 1 1 
    1 1 1 
    1 1 1 ];
    A2=imdilate(labels,B);%ͼ��A1���ṹԪ��B����
   diff = A2-labels;
   a=zeros(size(diff));
   a(diff>0)=1;
   a = uint8(a);
   r = Img(:,:,1);
   g = Img(:,:,2);
   b = Img(:,:,3);
   
   r(a==1)=255;
   g(a==1)=0;
   b(a==1)=0;
   ImgSeg = cat(3,r,g,b);
   
 figure,imshow(ImgSeg,[]);
 savepath = strcat(path,ImgIndex,'_seg.png');
%  imwrite(ImgSeg,savepath);
              
              
    end

 