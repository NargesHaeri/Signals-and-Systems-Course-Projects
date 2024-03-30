function msg=decoding(img,mapset)
end_symbol=';';
end_symbol_binary=dec2bin(find(strcmp(end_symbol,mapset(1,:))==1)-1);

binary_msg='';
for i=1:numel(img)
    num=dec2bin(img(i),8);
    binary_msg=strcat(binary_msg,num(8));
    if(rem(i,5)==0)
        if(binary_msg(end-4:end)==end_symbol_binary)
            break;
        end
    end
end

msg_len=length(binary_msg)/5;
index=[];
for i=1:msg_len
    index=[index, find(strcmp(binary_msg(5*i-4:5*i),mapset(2,:))==1) ];
end
msg=cell2mat(mapset(1,index));

end