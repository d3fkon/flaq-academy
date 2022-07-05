class Questions {
  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  String correctOption;
  Questions({
    required this.question,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.correctOption,
  });
}

List<Questions> quizQuestions = [
  Questions(
    question: 'Frontier let\'s you',
    option1: 'Stake',
    option2: 'Store Assets',
    option3: 'Swap',
    option4: 'All of the above',
    correctOption: 'All of the above',
  ),
  Questions(
    question: 'Does Frontier have a token?',
    option1: 'Yes',
    option2: 'No',
    option3: '',
    option4: '',
    correctOption: 'Yes',
  ),
  Questions(
    question: 'Does Frontier wallet support NFTs?',
    option1: 'Yes',
    option2: 'No',
    option3: '',
    option4: '',
    correctOption: 'Yes',
  ),
  Questions(
    question:
        'Does Frontier provide tools for portfolio tracking and management?',
    option1: 'Yes',
    option2: 'No',
    option3: '',
    option4: '',
    correctOption: 'Yes',
  ),
  Questions(
    question:
        'If you want to explore yield opportunities on Polygon, you have to..',
    option1: 'Use other DApps which offer yields on Polygon',
    option2: 'Use frontier, since it\'s a blockchain aggregator',
    option3: '',
    option4: '',
    correctOption: 'Use frontier, since it\'s a blockchain aggregator',
  ),
  Questions(
    question: 'What does Frontier do to ensure the safety of your assets?',
    option1: 'Audits',
    option2: 'Due Diligence',
    option3: 'Implement Cryptographic functionality',
    option4: 'All of the above',
    correctOption: 'All of the above',
  ),
  Questions(
    question:
        'As of June, 2022, Frontier supports more than __ blockchain networks.',
    option1: '25',
    option2: '10',
    option3: '8',
    option4: '5',
    correctOption: '25',
  ),
  Questions(
    question: 'Does Frontier support non evm chains like Zilliqa and Algorand?',
    option1: 'Yes',
    option2: 'No',
    option3: '',
    option4: '',
    correctOption: 'Yes',
  ),
  Questions(
    question:
        'Users can easily connect and use their preferred mobile wallets, such as Trust Wallet or MetaMask, on the Frontier platform.',
    option1: 'True',
    option2: 'False',
    option3: '',
    option4: '',
    correctOption: 'True',
  ),
  Questions(
    question:
        'Front token is mainly used to incentivize users into using the wallet and exploring the DeFi space.',
    option1: 'True',
    option2: 'False',
    option3: '',
    option4: '',
    correctOption: 'True',
  ),
];
