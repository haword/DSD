/*
  �������� 
    - ������� MovementItemFloatDesc (�������� ������� o������� ���� TFloat)
    - �����
    - ��������
*/

/*-------------------------------------------------------------------------------*/

CREATE TABLE MovementItemFloatDesc(
   Id                    SERIAL NOT NULL PRIMARY KEY, 
   Code                  TVarChar,
   ItemName              TVarChar
)

/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */



/*-------------------------------------------------------------------------------
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   
 29.06.13             * SERIAL
*/