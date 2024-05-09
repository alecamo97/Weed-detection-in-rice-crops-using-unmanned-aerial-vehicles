clear all

%% etiquetado
filename='Segmentado_40m.tif';

[A,R]=geotiffread(filename);
info=geotiffinfo(filename);

[r,c]=size(A);
vec_seg=reshape(A,r*c,1);
vec_seg_aux=vec_seg;

weed_value=1;

idx=find(vec_seg==weed_value);
L=length(idx);

count_lab=1;

h = waitbar(0,'Please wait...');
L1=L;
while ~isempty(idx)
    waitbar((L-L1)/L,h,'Please wait...');
    L_pix=1;
    i=1;
    pos_k_vec_obj=idx(1);
    idx_pos=pos_k_vec_obj;
    W=33;     % number of columns around current pixel
    pos_aux_k=[];
    for k=-W:W
        pos_aux_k=[pos_aux_k idx(1)+r*k-W:idx(1)+r*k+W];
    end
    pos_aux_k(find(pos_aux_k<1))=[];
    pos_aux_k(find(pos_aux_k>r*c))=[];
        
    while (i <= L_pix)
        pos_k=pos_k_vec_obj(i);
       %pos_k_vec=[pos_k-r, pos_k-1, pos_k+1, pos_k+r];
        pos_k_vec=[pos_k-r-1, pos_k-r, pos_k-r+1, pos_k-1, pos_k+1, pos_k+r-1, pos_k+r, pos_k+r+1];
        pos_k_vec(find(pos_k_vec<=0))=[];
        pos_k_vec(find(pos_k_vec>r*c))=[];
        for j=1:length(pos_k_vec)
            if isempty(find(pos_k_vec(j)== pos_aux_k))
                pos_k_vec(j)=-1;
            end
        end
        pos_k_vec(find(pos_k_vec==-1))=[];
        pos_k_vec_i=pos_k_vec(find(vec_seg(pos_k_vec)==weed_value));
       
        if ~isempty(pos_k_vec_i)
            for j=1:length(pos_k_vec_i)
                if L_pix-2*r>0;
                   pos_k_vec_j= L_pix-2*r;
                else
                  pos_k_vec_j=1;
                end  
                if  isempty(find(pos_k_vec_obj(pos_k_vec_j:end)==pos_k_vec_i(j)))
                    pos_k_vec_obj=[pos_k_vec_obj pos_k_vec_i(j)];
                    L_pix=L_pix+1;
                end
            end
        end
        i=i+1;
    end
    if L_pix > 7
        object_pix{count_lab}=pos_k_vec_obj;     
        vec_seg_aux(pos_k_vec_obj)=count_lab;
        count_lab=count_lab+1;
    else
        vec_seg_aux(pos_k_vec_obj)=0;
    end
    idx=find(vec_seg_aux==weed_value);
    L1=length(idx);
    
end
img=double(reshape(vec_seg_aux,r,c));

% %% guardar datos de etiquetato
% save('datos_etiquetado_2000.mat', 'R', 'info', 'r', 'c', 'object_pix')
% 
% %% Guardar la imagen de los pixeles etiquetado en formato tiff.
% geotiffwrite('etiquetado_40m_2000',double(img),R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
