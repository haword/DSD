-- View: Object_Unit_View

DROP VIEW IF EXISTS Object_Contract_View;

CREATE OR REPLACE VIEW Object_Contract_View AS 
       SELECT 
             Object_Contract.Id           AS Id
           , Object_Contract.Id           AS ContractId
           , Object_Contract.ObjectCode   AS Code
           , Object_Contract.ObjectCode   AS ContractCode
           , Object_Contract.ValueData    AS Name
           , ''::TVarChar                 AS InvNumber
           , ''::TVarChar                 AS ContractTagGroupName
           , ''::TVarChar                 AS ContractTagName
           , ''::TVarChar                 AS ContractKindName
           , 0::Integer                   AS ContractStateKindCode
           , NULL::TDateTime              AS startdate
           , NULL::TDateTime              AS enddate

           , Object_JuridicalBasis.Id         AS JuridicalBasisId
           , Object_JuridicalBasis.ValueData  AS JuridicalBasisName 
                     
           , Object_Juridical.Id         AS JuridicalId
           , Object_Juridical.ValueData  AS JuridicalName 

           , Object_GroupMemberSP.Id         AS GroupMemberSPId
           , Object_GroupMemberSP.ValueData  AS GroupMemberSPName

           , ObjectFloat_Deferment.ValueData ::Integer AS Deferment
           , ObjectFloat_Percent.ValueData   ::Tfloat  AS Percent

           , ObjectString_Comment.ValueData AS Comment
           
           , Object_Contract.isErased       AS isErased
           , 0 AS InfoMoneyId
           , 0 AS Contractstatekindid           

       FROM Object AS Object_Contract
           LEFT JOIN ObjectLink AS ObjectLink_Contract_JuridicalBasis
                                ON ObjectLink_Contract_JuridicalBasis.ObjectId = Object_Contract.Id
                               AND ObjectLink_Contract_JuridicalBasis.DescId = zc_ObjectLink_Contract_JuridicalBasis()
           LEFT JOIN Object AS Object_JuridicalBasis ON Object_JuridicalBasis.Id = ObjectLink_Contract_JuridicalBasis.ChildObjectId
           
           LEFT JOIN ObjectLink AS ObjectLink_Contract_Juridical
                                ON ObjectLink_Contract_Juridical.ObjectId = Object_Contract.Id
                               AND ObjectLink_Contract_Juridical.DescId = zc_ObjectLink_Contract_Juridical()
           LEFT JOIN Object AS Object_Juridical ON Object_Juridical.Id = ObjectLink_Contract_Juridical.ChildObjectId   

           LEFT JOIN ObjectLink AS ObjectLink_Contract_GroupMemberSP
                                ON ObjectLink_Contract_GroupMemberSP.ObjectId = Object_Contract.Id
                               AND ObjectLink_Contract_GroupMemberSP.DescId = zc_ObjectLink_Contract_GroupMemberSP()
           LEFT JOIN Object AS Object_GroupMemberSP ON Object_GroupMemberSP.Id = ObjectLink_Contract_GroupMemberSP.ChildObjectId             

           LEFT JOIN ObjectString AS ObjectString_Comment 
                                  ON ObjectString_Comment.ObjectId = Object_Contract.Id
                                 AND ObjectString_Comment.DescId = zc_ObjectString_Contract_Comment()

           LEFT JOIN ObjectFloat AS ObjectFloat_Deferment 
                                 ON ObjectFloat_Deferment.ObjectId = Object_Contract.Id
                                AND ObjectFloat_Deferment.DescId = zc_ObjectFloat_Contract_Deferment()

           LEFT JOIN ObjectFloat AS ObjectFloat_Percent
                                 ON ObjectFloat_Percent.ObjectId = Object_Contract.Id
                                AND ObjectFloat_Percent.DescId = zc_ObjectFloat_Contract_Percent()

       WHERE Object_Contract.DescId = zc_Object_Contract();

ALTER TABLE Object_Contract_View
  OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 05.03.17         * GroupMemberSP
 08.12.16         * add PercentCorr
 25.12.14                        * 
*/

-- ����
-- SELECT * FROM Object_Unit_View
