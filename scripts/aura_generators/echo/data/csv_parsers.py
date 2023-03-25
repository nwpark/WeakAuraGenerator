from pandas import DataFrame


def groupCsvRecordsByColumn(dataFrame: DataFrame, columnName: str) -> dict[str, list[dict]]:
    csvRecords = {}
    for columnValue in dataFrame[columnName].unique():
        filteredDataFrame = dataFrame[dataFrame[columnName] == columnValue]
        csvRecords[columnValue] = filteredDataFrame.to_dict(orient='records')

    return csvRecords
