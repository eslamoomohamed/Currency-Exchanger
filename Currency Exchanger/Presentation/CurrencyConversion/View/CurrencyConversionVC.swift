//
//  CurrencyConversionVC.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import UIKit
import Combine

class CurrencyConversionVC: UIViewController, StoryboardLoadable {
    
    @IBOutlet weak var baseCurrencyLabel: UILabel!
    @IBOutlet weak var baseCurrencyTextField: UITextField!
    @IBOutlet weak var seconderyCurrencyLabel: UILabel!
    @IBOutlet weak var seconderyCurrencyTextField: UITextField!
    @IBOutlet weak var convertCurrencyBtn: UIButton!
    @IBOutlet weak var amountToConvertTF: UITextField!
    @IBOutlet weak var resultValueLB: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    
    var currencyViewModel: CurrencyConversionViewModel!
    var fromPickerView = UIPickerView()
    var toPickerView = UIPickerView()
    var currencyList = [String]()
    private var selectedFromCurrency = ""
    private var selectedToCurrency = ""
    var shouldShowDetailsScreen: (() -> Void)?
    var shouldShowRecentScreen: (() -> Void)?

    private var listOfCurrenciesSubscriber: AnyCancellable?
    private var amountToConvertSubscriber: AnyCancellable?
    private var conversionSubscriber: AnyCancellable?
    private var exchangeValueSubscriber: AnyCancellable?
    private var buttonSubscriber: AnyCancellable?
    @Published private var didSelectFirstCurrency = false
    @Published private var didSelectSeconedCurrency = false
    @Published private var exchangeValue: String = ""
    private var validToConvert: AnyPublisher<Bool,Never> {
        return Publishers.CombineLatest3($didSelectFirstCurrency, $didSelectSeconedCurrency, $exchangeValue)
            .map { first, seconed, amount in
                return first && seconed && !amount.isEmpty
            }.eraseToAnyPublisher()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        assert(currencyViewModel != nil)
        handleButtonSubscriber()
        setupPickerViews()
        configureListOfCurrenciesSubscriber()
        setupAmountToConvertSubscriber()
        setupExchangeValueSubscriber()
    }
}

// MARK: Helper methods
extension CurrencyConversionVC {

    private func setupPickerViews() {
        fromPickerView.dataSource = self
        fromPickerView.delegate = self
        toPickerView.dataSource = self
        toPickerView.delegate = self
        baseCurrencyTextField.inputView = fromPickerView
        seconderyCurrencyTextField.inputView = toPickerView
    }

    private func configureListOfCurrenciesSubscriber() {
        listOfCurrenciesSubscriber = currencyViewModel.listOfCurrenciesSubject
            .sink { [weak self] currencies in
                self?.updatePickerView(with: currencies)
            }
    }

    private func updatePickerView(with currencies: [String]) {
        currencyList = currencies
        fromPickerView.reloadAllComponents()
        toPickerView.reloadAllComponents()
    }

    private func updateValueOfExchangeValue(with text: String) {
        if !text.isEmpty {
            exchangeValue = text
        } else {
            exchangeValue = ""
        }
        print("Text changed: \(text)")
    }

    func swap() {
        let temp = selectedFromCurrency
        selectedFromCurrency = selectedToCurrency
        selectedToCurrency = temp
        self.baseCurrencyTextField.text = selectedToCurrency
        self.seconderyCurrencyTextField.text = selectedFromCurrency
    }
    
}

extension CurrencyConversionVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        currencyList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        currencyList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard currencyList.isEmpty != true else {return}
        if pickerView == fromPickerView {
            let selectedCurrency = currencyList[row]
            baseCurrencyTextField.text = selectedCurrency
            selectedFromCurrency = selectedCurrency
            baseCurrencyTextField.resignFirstResponder()
            didSelectFirstCurrency = true
        } else if pickerView == toPickerView {
            let selectedCurrency = currencyList[row]
            seconderyCurrencyTextField.text = selectedCurrency
            selectedToCurrency = selectedCurrency
            seconderyCurrencyTextField.resignFirstResponder()
            didSelectSeconedCurrency = true
        }
    }
}

// MARK: IBActions
extension CurrencyConversionVC {
    
    @IBAction func convertCurrencyBtnTap(_ sender: Any) {
        currencyViewModel.convertCurrency(amount: Double(exchangeValue) ?? 0, base: selectedFromCurrency, target: selectedToCurrency)
    }
    @IBAction func DetailsBtnTap(_ sender: Any) {
        shouldShowDetailsScreen?()
    }

    @IBAction func sswapButtonTap(_ sender: Any) {
        swap()
    }

    @IBAction func recentBtnTap(_ sender: Any) {
        shouldShowRecentScreen?()
    }

}


// MARK: Subscribers
extension CurrencyConversionVC {
    
    private func handleButtonSubscriber() {
        buttonSubscriber = validToConvert
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: convertCurrencyBtn)
    }
    
    private func setupAmountToConvertSubscriber() {
        amountToConvertSubscriber = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: amountToConvertTF)
            .compactMap { notification in
                return (notification.object as? UITextField)?.text
            }
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.updateValueOfExchangeValue(with: text)
            }
    }
    
    private func setupExchangeValueSubscriber() {
        exchangeValueSubscriber = currencyViewModel.$exchangeValue
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                self?.resultValueLB.text = String(value)
                print("Exchange Value Changed: \(value)")
            }
    }
}
