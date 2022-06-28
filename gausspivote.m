function[x]=gausspivote(A,b)

[m,n]=size(A); %obtenemos el tamaño de nuestra matriz

%verificación sistema compatible determinado 
    if m~=n
        disp('Error.Matriz de coeficientes tiene que ser cuadrada')
    end
    
    if [m,1]~=size(b)
        disp('Error. Sistema no coherente')     
    end

    if det(A)==0
        disp('Error. Matriz de coeficientes singular. Solución no existe o no es única.')
    end

x=zeros(m,1); %vector de soluciones 


    for i=1:n-1
        %hallamos el máximo valor de la columna i, y su posición

        [pivote,posicion]=max(A(:,i));

        %creamos un vector auxiliar que contiene la fila del pivote elegido
        %creamos una variable que contiene el elemento del vector b en la
        %posición i 

        aux=A(i,:);
        aux2=b(i);

        %intercambiamos en la matriz A, la fila i por la fila con el pivote
        %haciendo uso de nuestro vector auxiliar, solo si el pivote es
        %distinto de la fila en la que estamos 

        if i~=posicion 
            A(i,:)=A(posicion,:);
            A(posicion,:)=aux;
            b(i)=b(posicion);
            b(posicion)=aux2;
        end 

      
       
  
    %realizamos la eliminación de coeficientes de la columna por debajo del pivote
        for j=i+1:n 

            z=A(j,i);
            A(j,i:n)=A(j,i:n)-(z/A(i,i))*A(i,i:n); 
            b(j)=b(j)-(z/A(i,i))*b(i);
        
        end
    end

    %Ahora tenemos una matriz triangular superior A. El siguiente paso consiste en 
    %obtener la solución de nuestro sistema con el método de sustitución
    %hacia atrás 
 
x(m)=b(m)/A(m,m);

for k=m-1:-1:1
    sum=0;
   for j=k+1:1:n
       sum=sum+A(k,j)*x(j);
   end
    x(k)=(1/A(k,k))*(b(k)-sum);
end




end
