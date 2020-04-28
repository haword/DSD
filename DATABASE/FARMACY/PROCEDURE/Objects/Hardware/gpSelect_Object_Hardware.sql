-- Function: gpSelect_Object_Hardware()

DROP FUNCTION IF EXISTS gpSelect_Object_Hardware(boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Object_Hardware(
    IN inisErased    boolean,
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar, isCashRegister boolean, CashRegisterName TVarChar
             , UnitId Integer, UnitCode Integer, UnitName TVarChar
             , BaseBoardProduct TVarChar, ProcessorName TVarChar, DiskDriveModel TVarChar, PhysicalMemory TVarChar
             , Identifier TVarChar, Comment TVarChar
             , isErased boolean) AS
$BODY$BEGIN


   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Hardware()());

   RETURN QUERY
   SELECT
          Object_Hardware.Id                 AS Id
        , Object_Hardware.ObjectCode         AS Code
        , Object_Hardware.ValueData          AS Name

        , Object_CashRegister.Id IS NOT NULL AS isCashRegister
        , Object_CashRegister.ValueData      AS CashRegisterName

        , Object_Unit.Id                     AS UnitId
        , Object_Unit.ObjectCode             AS UnitCode
        , Object_Unit.ValueData              AS UnitName

        , ObjectString_BaseBoardProduct.ValueData                   AS BaseBoardProduct
        , ObjectString_ProcessorName.ValueData                      AS ProcessorName
        , ObjectString_DiskDriveModel.ValueData                     AS DiskDriveModel
        , ObjectString_PhysicalMemory.ValueData                     AS PhysicalMemory
        
        , ObjectString_Identifier.ValueData                         AS Identifier
        , ObjectString_Comment.ValueData                            AS Comment

        , Object_Hardware.isErased           AS isErased

   FROM Object AS Object_Hardware
        LEFT JOIN ObjectLink AS ObjectLink_Hardware_Unit
                             ON ObjectLink_Hardware_Unit.ObjectId = Object_Hardware.Id
                            AND ObjectLink_Hardware_Unit.DescId = zc_ObjectLink_Hardware_Unit()
        LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = ObjectLink_Hardware_Unit.ChildObjectId

        LEFT JOIN ObjectLink AS ObjectLink_Hardware_CashRegister
                             ON ObjectLink_Hardware_CashRegister.ObjectId = Object_Hardware.Id
                            AND ObjectLink_Hardware_CashRegister.DescId = zc_ObjectLink_Hardware_CashRegister()
        LEFT JOIN Object AS Object_CashRegister ON Object_CashRegister.Id = ObjectLink_Hardware_CashRegister.ChildObjectId

        LEFT JOIN ObjectString AS ObjectString_BaseBoardProduct
                               ON ObjectString_BaseBoardProduct.ObjectId = Object_Hardware.Id
                              AND ObjectString_BaseBoardProduct.DescId = zc_ObjectString_Hardware_BaseBoardProduct()
        LEFT JOIN ObjectString AS ObjectString_ProcessorName
                               ON ObjectString_ProcessorName.ObjectId = Object_Hardware.Id
                              AND ObjectString_ProcessorName.DescId = zc_ObjectString_Hardware_ProcessorName()
        LEFT JOIN ObjectString AS ObjectString_DiskDriveModel
                               ON ObjectString_DiskDriveModel.ObjectId = Object_Hardware.Id
                              AND ObjectString_DiskDriveModel.DescId = zc_ObjectString_Hardware_DiskDriveModel()
        LEFT JOIN ObjectString AS ObjectString_PhysicalMemory
                              ON ObjectString_PhysicalMemory.ObjectId = Object_Hardware.Id
                             AND ObjectString_PhysicalMemory.DescId = zc_ObjectString_Hardware_PhysicalMemory()

        LEFT JOIN ObjectString AS ObjectString_Identifier
                              ON ObjectString_Identifier.ObjectId = Object_Hardware.Id
                             AND ObjectString_Identifier.DescId = zc_ObjectString_Hardware_Identifier()
        LEFT JOIN ObjectString AS ObjectString_Comment
                              ON ObjectString_Comment.ObjectId = Object_Hardware.Id
                             AND ObjectString_Comment.DescId = zc_ObjectString_Hardware_Comment()

   WHERE Object_Hardware.DescId = zc_Object_Hardware()
     AND (Object_Hardware.isErased = False or inIsErased = True);

END;$BODY$


LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Object_Hardware(boolean, TVarChar) OWNER TO postgres;


-------------------------------------------------------------------------------
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.    ������ �.�.   ������ �.�.
 12.04.20                                                                      *
*/

-- ����
-- SELECT * FROM gpSelect_Object_Hardware(False, '3')