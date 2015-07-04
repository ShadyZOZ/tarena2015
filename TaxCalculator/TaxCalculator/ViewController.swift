//
//  ViewController.swift
//  Tax Calculator
//
//  Created by tony on 7/3/15.
//  Copyright (c) 2015 shadyzoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var salaryTextField: UITextField!
    var bonusTextField: UITextField!
    var mealTextField: UITextField!
    var retirementInsuranceTextField: UITextField!
    var jobInsuranceTextField: UITextField!
    var medicalInsuranceTextField: UITextField!
    var publicFundTextField: UITextField!
    var resultTextField: UITextField!
    var afterTaxIncomeTextField: UITextField!
    
    var textFields = [UITextField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // get screen width & height
        var width = CGRectGetWidth(self.view.bounds)
        var height = CGRectGetHeight(self.view.bounds)
        
        // show title
        var title = UILabel(frame: CGRectMake(0, 64, width, 40))
        title.text = "个税计算器"
        title.textColor = UIColor.purpleColor()
        title.font = UIFont.boldSystemFontOfSize(24)
        title.textAlignment = NSTextAlignment.Center
        self.view.addSubview(title)
        
        // 视图 -- UIView
        var incomeView = UIView(frame: CGRectMake(30, 120, width-60, 110))
        var insuranceView = UIView(frame: CGRectMake(30, 260, width-60, 145))
        var resultView = UIView(frame: CGRectMake(30, 430, width-60, 75))
        
        incomeView.backgroundColor = UIColor.orangeColor()
        insuranceView.backgroundColor = UIColor.cyanColor()
        resultView.backgroundColor = UIColor.lightGrayColor()
        
        self.view.addSubview(incomeView)
        self.view.addSubview(insuranceView)
        self.view.addSubview(resultView)

        // 标签 -- UILabel
        var salaryLable = UILabel(frame: CGRectMake(25, 5, 100, 30))
        var bonusLable = UILabel(frame: CGRectMake(25, 40, 100, 30))
        var mealLable = UILabel(frame: CGRectMake(25, 75, 100, 30))
        
        var retirementInsuranceLable = UILabel(frame: CGRectMake(25, 5, 100, 30))
        var jobInsuranceLable = UILabel(frame: CGRectMake(25, 40, 100, 30))
        var medicalInsuranceLable = UILabel(frame: CGRectMake(25, 75, 100, 30))
        var publicFundLable = UILabel(frame: CGRectMake(25, 110, 100, 30))
        
        var resultLable = UILabel(frame: CGRectMake(25, 5, 100, 30))
        var afterTaxIncomeLabel = UILabel(frame: CGRectMake(25, 40, 100, 30))
        
        // 标签内容
        salaryLable.text = "基本工资:"
        bonusLable.text = "绩效奖金:"
        mealLable.text = "饭       补:"
        
        retirementInsuranceLable.text = "养老保险:"
        jobInsuranceLable.text = "失业保险:"
        medicalInsuranceLable.text = "医疗保险:"
        publicFundLable.text = "公  积  金:"
        
        resultLable.text = "应纳个税:"
        afterTaxIncomeLabel.text = "实际收入:"
        
        // 添加视图
        incomeView.addSubview(salaryLable)
        incomeView.addSubview(bonusLable)
        incomeView.addSubview(mealLable)
        
        insuranceView.addSubview(retirementInsuranceLable)
        insuranceView.addSubview(jobInsuranceLable)
        insuranceView.addSubview(medicalInsuranceLable)
        insuranceView.addSubview(publicFundLable)
        
        resultView.addSubview(resultLable)
        resultView.addSubview(afterTaxIncomeLabel)
        
        //文本框 -- UITextField
        salaryTextField = UITextField(frame: CGRectMake(135, 5, 150, 30))
        bonusTextField = UITextField(frame: CGRectMake(135, 40, 150, 30))
        mealTextField = UITextField(frame: CGRectMake(135, 75, 150, 30))
        
        retirementInsuranceTextField = UITextField(frame: CGRectMake(135, 5, 150, 30))
        jobInsuranceTextField = UITextField(frame: CGRectMake(135, 40, 150, 30))
        medicalInsuranceTextField = UITextField(frame: CGRectMake(135, 75, 150, 30))
        publicFundTextField = UITextField(frame: CGRectMake(135, 110, 150, 30))
        
        resultTextField = UITextField(frame: CGRectMake(135, 5, 150, 30))
        afterTaxIncomeTextField = UITextField(frame: CGRectMake(135, 40, 150, 30))

        // 添加子视图
        incomeView.addSubview(salaryTextField)
        incomeView.addSubview(bonusTextField)
        incomeView.addSubview(mealTextField)
        
        insuranceView.addSubview(retirementInsuranceTextField)
        insuranceView.addSubview(jobInsuranceTextField)
        insuranceView.addSubview(medicalInsuranceTextField)
        insuranceView.addSubview(publicFundTextField)
        
        resultView.addSubview(resultTextField)
        resultView.addSubview(afterTaxIncomeTextField)
        
        textFields = [salaryTextField, bonusTextField, mealTextField, retirementInsuranceTextField, jobInsuranceTextField, medicalInsuranceTextField, publicFundTextField, resultTextField, afterTaxIncomeTextField]
        
        // common attributes
        for textField in textFields
        {
            if textField == resultTextField || textField == afterTaxIncomeTextField
            {
                textField.enabled = false
            }
            else
            {
                textField.clearButtonMode = UITextFieldViewMode.WhileEditing
                textField.keyboardType = UIKeyboardType.DecimalPad
                textField.delegate = self
            }
            textField.borderStyle = UITextBorderStyle.RoundedRect
        }
        
        // signatural
        var sign = UILabel(frame: CGRectMake(0, height - 70, width, 70))
        sign.text = "Tax Calculater by Shady.\nSource Code: https://github.com/shadyzoz/tarena2015"
        sign.font = UIFont.systemFontOfSize(14)
        sign.textAlignment = NSTextAlignment.Center
        sign.numberOfLines = 2
        self.view.addSubview(sign)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for view in self.view.subviews
        {
            for subView in view.subviews
            {
                if subView.isKindOfClass(UITextField)
                {
                   subView.resignFirstResponder()
                }
            }
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool
    {
        if textField == salaryTextField
        {
            retirementInsuranceTextField.text = Float2String(String2Float(salaryTextField.text) * 0.08)
            jobInsuranceTextField.text = Float2String(String2Float(salaryTextField.text) * 0.002)
            medicalInsuranceTextField.text = Float2String(String2Float(salaryTextField.text) * 0.02 + 3)
            publicFundTextField.text = Float2String(String2Float(salaryTextField.text) * 0.12)
        }
        for field in textFields
        {
            if field.text.isEmpty
            {
                field.text = "0.00"
            }
        }
        textField.text = Float2String(String2Float(textField.text))
        calTax()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if count(string) > 1
        {
            return false
        }
        if string == "."
        {
            if textField.text.componentsSeparatedByString(string).count > 1
            {
                return false
            }
        }
        return true
    }
    
    func String2Float(string: String) -> Float
    {
        return NSString(string: string).floatValue
    }
    
    func Float2String(num: Float) -> String
    {
        return NSString(format: "%.2f", num) as String
    }
    
    func calTax()
    {
        var totalIncome = String2Float(salaryTextField.text) + String2Float(bonusTextField.text) + String2Float(mealTextField.text)
        var expance  = String2Float(retirementInsuranceTextField.text) + String2Float(jobInsuranceTextField.text) + String2Float(medicalInsuranceTextField.text) + String2Float(publicFundTextField.text)
        var income = totalIncome - expance
        var taxLevel = income - 3500
        
        if taxLevel <= 0
        {
            resultTextField.text = Float2String(0.0)
        }
        else if taxLevel <= 1500
        {
            resultTextField.text = Float2String(taxLevel * 0.03)
        }
        else if taxLevel <= 4500
        {
            resultTextField.text = Float2String(taxLevel * 0.1 - 105)
        }
        else if taxLevel <= 9000
        {
            resultTextField.text = Float2String(taxLevel * 0.2 - 555)
        }
        else if taxLevel <= 35000
        {
            resultTextField.text = Float2String(taxLevel * 0.25 - 1005)
        }
        else if taxLevel <= 55000
        {
            resultTextField.text = Float2String(taxLevel * 0.3 - 2755)
        }
        else if taxLevel <= 80000
        {
            resultTextField.text = Float2String(taxLevel * 0.35 - 5505)
        }
        else
        {
            resultTextField.text = Float2String(taxLevel * 0.45 - 13505)
        }
        
        afterTaxIncomeTextField.text = Float2String(income - String2Float(resultTextField.text))
    }
}