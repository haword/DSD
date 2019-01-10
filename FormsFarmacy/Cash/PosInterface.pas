unit PosInterface;

interface

type

   TMsgDescriptionProc = procedure(AMsgDescription : string) of object;

   IPos = interface
      procedure SetMsgDescriptionProc(Value: TMsgDescriptionProc);
      function GetMsgDescriptionProc: TMsgDescriptionProc;

      function Payment(ASumma : Currency) : Boolean;
      procedure Cancel;
      property OnMsgDescriptionProc: TMsgDescriptionProc read GetMsgDescriptionProc write SetMsgDescriptionProc;
   end;

implementation

end.
