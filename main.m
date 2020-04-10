
function main
    n = input(' Введите   n =   ') ;
    e = input(' Введите   e =   ') ;
    matrix = createMatrix(n,"mixed",n,10);
%     disp(matrix); %задаем тип матрицы
   iter(matrix,n,e);
   iter1(matrix,n,e);
end

function matrix = createMatrix(size, type, a, b)
    matrix = zeros(size);
    
%     n = size-1;
    for i = 2:size-1
        matrix(i,-1+i) = 1;
        matrix(i,0+i) = -2;
        matrix(i,1+i) = 1;
    end
    
    if type == "default"
        matrix(1,1) = -2;
        matrix(1,2) = 1;
        
        matrix(size,size) = -2;
        matrix(size,size-1) = 1;
    elseif type == "nayman"
        matrix(1,1) = 1;
        matrix(size,size) = 1;
    elseif type == "dirikhle"
        matrix(1,1) = -1;
        matrix(1,2) = 1;
        
        matrix(size,size) = 1;
        matrix(size,size-1) = -1;
    elseif type == "mixed"
        h = (b-a)/size;
        
        matrix(1,1) = h-a;
        matrix(1,2) = a;
        
        matrix(size,size) = h+a;
        matrix(size,size-1) = -a;
    end
    
    return
end

function iter(matrix,n,e)
    %метод прямой итерации
    
    disp("Matrix:   ");
    disp(matrix);
    x = zeros(n, 1);
    x(1,1) = 1;
    l = 0;
    while true
        nextx = matrix * x;
%         disp(nextx);
        nextl = dot(nextx, x) / dot(x, x); 
        if ((abs(nextl-l))<= e) 
           disp("Max own value:   ");
           disp(nextl);
           break;   
        else
            x = nextx;
            l = nextl;
        end
    end 
end

function iter1(matrix,n,e)
%     метод обратной итерации
   
   if det(matrix) == 0
       disp("Singular matrix");
       return;
   end
   
   reverseMatrix = inv(matrix);
   disp("Reverse matrix:   ");
   disp(reverseMatrix);
   x = zeros(n, 1);
   x(1,1) = 1;
   l = 0;
   while (true)
       nextx = reverseMatrix * x;
       nextl = dot(x, x) / dot(nextx, x);  
       if ((abs(nextl-l))<= e) 
          disp("Min own value:   ");
          disp(nextl);
          break;   
       else
           x = nextx;
           l = nextl;
        end
   end 
end

