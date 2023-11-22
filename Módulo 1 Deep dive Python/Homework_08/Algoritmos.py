from abc import ABC, abstractmethod
import random


class AlgoritmoOrdenamiento(ABC):

    def __init__(self) -> None:
        self.__pasos = 0

    @abstractmethod
    def ordenar(self, lista:list) -> list:
        pass
    
    @abstractmethod
    def pasos(self) -> int:
        pass



class Seleccion(AlgoritmoOrdenamiento):

    def __init__(self) -> None:
        super().__init__()

    def ordenar(self, lista:list) -> list:
        """
        Este método recibe una lista desordenada y la ordena con el algoritmo de 
        selección. Retorna una lista ordenada.
        """
        self.__pasos = 0
        for i in range(len(lista)):  
            minimo = i
            for j in range(i + 1,len(lista)) :
                self.__pasos += 1
                if lista[j] < lista[minimo] :
                    minimo = j
            if lista[i] > lista[minimo]:
                lista[i], lista[minimo] = lista[minimo], lista[i]
        return lista

    @property
    def pasos(self) -> int:
        return self.__pasos


class Burbuja(AlgoritmoOrdenamiento):

    def __init__(self) -> None:
        super().__init__()

    def ordenar(self, lista:list) -> list:
        """
        Este método recibe una lista desordenada y la ordena con el algoritmo de 
        burbujeo. Retorna una lista ordenada.
        """
        self.__pasos = 0
        a = 0
        conmutacion = True
        while conmutacion:
            conmutacion = False
            a += 1
            for i in range(len(lista) - a):
                if lista[i] > lista[i + 1]:
                    conmutacion = True
                    lista[i], lista[i + 1] = lista[i + 1], lista[i]
                self.__pasos += 1
        
        return lista
    
    @property
    def pasos(self) -> int:
        return self.__pasos
    
    

def test() -> None:
    lista = []
    while len(lista) < 10:
        n = random.randint(0,400)
        if n not in lista:
            lista.append(n)
    print(lista)
    s = Seleccion()
    b = Burbuja()
    lista_s = lista[:]
    lista_b = lista[:]
    print(f'\nLista ordenada por selección: {s.ordenar(lista_s)}\nPasos: {s.pasos}\n')
    print(f'\nLista ordenada por burbujeo: {b.ordenar(lista_b)}\nPasos: {b.pasos}')
    

if __name__ == '__main__':
    test()
