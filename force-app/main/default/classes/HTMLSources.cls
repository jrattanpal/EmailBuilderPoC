global class HTMLSources extends VisualEditor.DynamicPickList{
    
    global override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('HTML Source 1', '<h3>default value</h3>');
        return defaultValue;
    }
    global override VisualEditor.DynamicPickListRows getValues() {
        VisualEditor.DataRow value1 = new VisualEditor.DataRow('HTML Source 1', '<lightning-card></lightning-card>');
        VisualEditor.DataRow value2 = new VisualEditor.DataRow('HTML Source 2', '<h1>test html picklist</h1>');
        VisualEditor.DataRow value3 = new VisualEditor.DataRow('HTML Source 3', '<div>hello<p>testing html picklist</p></div>');
        VisualEditor.DataRow value4 = new VisualEditor.DataRow('HTML Source 4', '<h1>hello</h1>');
        VisualEditor.DataRow value5 = new VisualEditor.DataRow('HTML Source 5', '<h2>goodbye</h2>');
        VisualEditor.DynamicPickListRows  myValues = new VisualEditor.DynamicPickListRows();
        myValues.addRow(value1);
        myValues.addRow(value2);
        myValues.addRow(value3);
        myValues.addRow(value4);
        myValues.addRow(value5);
        return myValues;
    }
}