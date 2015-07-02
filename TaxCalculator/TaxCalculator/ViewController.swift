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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // get screen width & height
        var width = CGRectGetWidth(UIScreen.mainScreen().bounds)
        var height = CGRectGetHeight(UIScreen.mainScreen().bounds)
        
        // show title
        var title = UILabel(frame: CGRectMake(0, 64, width, 40))
        title.text = "个税计算器"
        title.textColor = UIColor.purpleColor()
        title.font = UIFont.boldSystemFontOfSize(24)
        title.textAlignment = NSTextAlignment.Center
        self.view.addSubview(title)
        
        // 视图-- UIView
        
        // 收入
        var incomeView = UIView(frame: CGRectMake(30, 120, width-60, 110))
        incomeView.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(incomeView)
        
        var salaryLable = UILabel(frame: CGRectMake(25, 5, 100, 30))
        salaryLable.text = "基本工资:"
        incomeView.addSubview(salaryLable)
        
        salaryTextField = UITextField(frame: CGRectMake(135, 5, 150, 30))
        salaryTextField.borderStyle = UITextBorderStyle.RoundedRect
        salaryTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        salaryTextField.keyboardType = UIKeyboardType.DecimalPad
        salaryTextField.delegate = self
        incomeView.addSubview(salaryTextField)
        
        var bonusLable = UILabel(frame: CGRectMake(25, 40, 100, 30))
        bonusLable.text = "绩效奖金:"
        incomeView.addSubview(bonusLable)
        
        bonusTextField = UITextField(frame: CGRectMake(135, 40, 150, 30))
        bonusTextField.borderStyle = UITextBorderStyle.RoundedRect
        bonusTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        bonusTextField.keyboardType = UIKeyboardType.DecimalPad
        bonusTextField.delegate = self
        incomeView.addSubview(bonusTextField)
        
        var mealLable = UILabel(frame: CGRectMake(25, 75, 100, 30))
        mealLable.text = "饭       补:"
        incomeView.addSubview(mealLable)
        
        mealTextField = UITextField(frame: CGRectMake(135, 75, 150, 30))
        mealTextField.borderStyle = UITextBorderStyle.RoundedRect
        mealTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        mealTextField.keyboardType = UIKeyboardType.DecimalPad
        mealTextField.delegate = self
        incomeView.addSubview(mealTextField)
        
        // 保险
        var insuranceView = UIView(frame: CGRectMake(30, 260, width-60, 145))
        insuranceView.backgroundColor = UIColor.cyanColor()
        self.view.addSubview(insuranceView)
        
        var retirementInsuranceLable = UILabel(frame: CGRectMake(25, 5, 100, 30))
        retirementInsuranceLable.text = "养老保险:"
        insuranceView.addSubview(retirementInsuranceLable)
        
        retirementInsuranceTextField = UITextField(frame: CGRectMake(135, 5, 150, 30))
        retirementInsuranceTextField.borderStyle = UITextBorderStyle.RoundedRect
        retirementInsuranceTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        retirementInsuranceTextField.keyboardType = UIKeyboardType.DecimalPad
        retirementInsuranceTextField.delegate = self
        insuranceView.addSubview(retirementInsuranceTextField)
        
        var jobInsuranceLable = UILabel(frame: CGRectMake(25, 40, 100, 30))
        jobInsuranceLable.text = "失业保险:"
        insuranceView.addSubview(jobInsuranceLable)
        
        jobInsuranceTextField = UITextField(frame: CGRectMake(135, 40, 150, 30))
        jobInsuranceTextField.borderStyle = UITextBorderStyle.RoundedRect
        jobInsuranceTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        jobInsuranceTextField.keyboardType = UIKeyboardType.DecimalPad
        jobInsuranceTextField.delegate = self
        insuranceView.addSubview(jobInsuranceTextField)
        
        var medicalInsuranceLable = UILabel(frame: CGRectMake(25, 75, 100, 30))
        medicalInsuranceLable.text = "医疗保险:"
        insuranceView.addSubview(medicalInsuranceLable)
        
        medicalInsuranceTextField = UITextField(frame: CGRectMake(135, 75, 150, 30))
        medicalInsuranceTextField.borderStyle = UITextBorderStyle.RoundedRect
        medicalInsuranceTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        medicalInsuranceTextField.keyboardType = UIKeyboardType.DecimalPad
        medicalInsuranceTextField.delegate = self
        insuranceView.addSubview(medicalInsuranceTextField)
        
        var publicFundLable = UILabel(frame: CGRectMake(25, 110, 100, 30))
        publicFundLable.text = "公  积  金:"
        insuranceView.addSubview(publicFundLable)
        
        publicFundTextField = UITextField(frame: CGRectMake(135, 110, 150, 30))
        publicFundTextField.borderStyle = UITextBorderStyle.RoundedRect
        publicFundTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        publicFundTextField.keyboardType = UIKeyboardType.DecimalPad
        publicFundTextField.delegate = self
        insuranceView.addSubview(publicFundTextField)
        
        // 税费结果
        var resultView = UIView(frame: CGRectMake(30, 430, width-60, 75))
        resultView.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(resultView)
        
        var resultLable = UILabel(frame: CGRectMake(25, 5, 100, 30))
        resultLable.text = "应纳个税:"
        resultView.addSubview(resultLable)
        
        resultTextField = UITextField(frame: CGRectMake(135, 5, 150, 30))
        resultTextField.borderStyle = UITextBorderStyle.RoundedRect
        resultTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        resultTextField.enabled = false
        resultView.addSubview(resultTextField)
        
        var afterTaxIncomeLabel = UILabel(frame: CGRectMake(25, 40, 100, 30))
        afterTaxIncomeLabel.text = "实际收入:"
        resultView.addSubview(afterTaxIncomeLabel)
        
        afterTaxIncomeTextField = UITextField(frame: CGRectMake(135, 40, 150, 30))
        afterTaxIncomeTextField.borderStyle = UITextBorderStyle.RoundedRect
        afterTaxIncomeTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        afterTaxIncomeTextField.enabled = false
        resultView.addSubview(afterTaxIncomeTextField)
        
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
        salaryTextField.resignFirstResponder()
        bonusTextField.resignFirstResponder()
        mealTextField.resignFirstResponder()
        retirementInsuranceTextField.resignFirstResponder()
        jobInsuranceTextField.resignFirstResponder()
        medicalInsuranceTextField.resignFirstResponder()
        publicFundTextField.resignFirstResponder()
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool
    {
        if textField == salaryTextField
        {
            if bonusTextField.text.isEmpty
            {
                bonusTextField.text = "0.00"
            }
            if mealTextField.text.isEmpty
            {
                mealTextField.text = "0.00"
            }
            retirementInsuranceTextField.text = Double2String(String2Double(salaryTextField.text) * 0.08)
            jobInsuranceTextField.text = Double2String(String2Double(salaryTextField.text) * 0.002)
            medicalInsuranceTextField.text = Double2String(String2Double(salaryTextField.text) * 0.02 + 3)
            publicFundTextField.text = Double2String(String2Double(salaryTextField.text) * 0.12)
        }
        textField.text = Double2String(String2Double(textField.text))
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
    
    func String2Double(string: String) -> Double
    {
        return (string as NSString).doubleValue
    }
    
    func Double2String(num: Double) -> String
    {
        return NSString(format: "%.2f", num) as String
    }
    
    func calTax()
    {
        var totalIncome = String2Double(salaryTextField.text) + String2Double(bonusTextField.text) + String2Double(mealTextField.text)
        var expance  = String2Double(retirementInsuranceTextField.text) + String2Double(jobInsuranceTextField.text) + String2Double(medicalInsuranceTextField.text) + String2Double(publicFundTextField.text)
        var income = totalIncome - expance
        var taxLevel = income - 3500
        
        if taxLevel <= 0
        {
            resultTextField.text = Double2String(0.0)
        }
        else if taxLevel <= 1500
        {
            resultTextField.text = Double2String(taxLevel * 0.03)
        }
        else if taxLevel <= 4500
        {
            resultTextField.text = Double2String(taxLevel * 0.1 - 105)
        }
        else if taxLevel <= 9000
        {
            resultTextField.text = Double2String(taxLevel * 0.2 - 555)
        }
        else if taxLevel <= 35000
        {
            resultTextField.text = Double2String(taxLevel * 0.25 - 1005)
        }
        else if taxLevel <= 55000
        {
            resultTextField.text = Double2String(taxLevel * 0.3 - 2755)
        }
        else if taxLevel <= 80000
        {
            resultTextField.text = Double2String(taxLevel * 0.35 - 5505)
        }
        else
        {
            resultTextField.text = Double2String(taxLevel * 0.45 - 13505)
        }
        
        afterTaxIncomeTextField.text = Double2String(income - String2Double(resultTextField.text))
    }
}