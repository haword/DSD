/*
  �������� 
    - ������� Object_WMS
    - ������
    - ��������
*/

-- DROP TABLE Object_WMS

/*-------------------------------------------------------------------------------*/

CREATE TABLE Object_WMS(
   Id                    BIGSERIAL NOT NULL PRIMARY KEY, 
   ProcName              TVarChar  NOT NULL,
   TagName               TVarChar  NOT NULL,
   ActionName            TVarChar  NOT NULL,
   RowNum                Integer   NOT NULL,
   RowData               Text      NOT NULL,
   ObjectId              Integer   NOT NULL,
   GroupId               Integer   NOT NULL
   );
/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */
CREATE INDEX idx_Object_WMS_ProcName ON Object_WMS (ProcName);
CREATE INDEX idx_Object_WMS_TagName  ON Object_WMS (TagName);

/*-------------------------------------------------------------------------------*/
/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   ������� �.�.    
20.08.19               *
*/