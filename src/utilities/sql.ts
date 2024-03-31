export const completeQuestionMarks = (query: string, values: any[]): string => {
    values.forEach(value => {
        if (typeof value === 'string') {
            value = value.replace("'", "''");
        };
        query = query.replace('/?/', value);
    })
    return query;
};