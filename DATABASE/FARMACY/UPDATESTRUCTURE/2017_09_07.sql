DROP INDEX IF EXISTS idx_MovementItemContainer_WhereObjectId_analyzer_OperDate;
CREATE INDEX idx_MovementItemContainer_WhereObjectId_analyzer_OperDate ON MovementItemContainer (WhereObjectId_analyzer, OperDate);